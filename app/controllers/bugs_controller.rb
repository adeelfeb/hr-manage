class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_bug, only: %i[edit show update]
  before_action :authorize_bug_creation, only: [:new, :create]


  def index
    @bugs = case
            when current_user.is_developer?
              @project.bugs.where(developer_id: current_user.id)
            when current_user.is_qa?
              @project.bugs.where(user_id: current_user.id)
            else # manager or admin
              @project.bugs
            end
  end

  def show
    if current_user.is_developer? && @bug.developer_id != current_user.id
      redirect_to project_path(@project), alert: "Not authorized to view this bug."
    elsif current_user.is_qa? && @bug.user_id != current_user.id
      redirect_to project_path(@project), alert: "Not authorized to view this bug."
    end
    # Otherwise, it's okay to render
  end



  def new
    @bug = @project.bugs.build
  end


  def create
    @bug = @project.bugs.build(bug_params)
    @bug.user = current_user  # the QA who reported the bug

    # if @bug.save
    #   redirect_to project_path(@project), notice: "Bug created successfully."
    # else
    #   render :new
    # end

    if @bug.save
      @bug.developer_ids = params[:bug][:developer_ids].reject(&:blank?) if params[:bug][:developer_ids]
      redirect_to project_path(@project), notice: "Bug created successfully."
    else
      render :new
    end

  end

  


  def update
    # if @bug.update(filtered_bug_params)
    #   redirect_to project_path(@bug.project), notice: "Bug updated successfully."
    # else
    #   render :edit, status: :unprocessable_entity
    # end
    if @bug.update(filtered_bug_params)
      if current_user.is_manager? && params[:bug][:developer_ids]
        @bug.developer_ids = params[:bug][:developer_ids].reject(&:blank?)
      end
      redirect_to project_path(@bug.project), notice: "Bug updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end

  end

  private

  def filtered_bug_params
    if current_user.is_manager?
      params.require(:bug).permit(:title, :description, :bug_category, :progress_state, :developer_id, :image)
    elsif current_user.is_developer?
      params.require(:bug).permit(:progress_state)
    elsif current_user.is_qa?
      params.require(:bug).permit(:title, :description, :bug_category, :image)
    else
      {} # No update permission
    end
  end


  

  def authorize_bug_creation
  unless current_user.is_qa? || current_user.is_manager?
    redirect_to root_path, alert: "You are not authorized to create bugs."
  end
end


  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug = @project.bugs.find(params[:id])
  end

  def bug_params
    if current_user.is_manager?
      params.require(:bug).permit(:title, :description, :bug_category, :progress_state, :image, developer_ids: [])
    elsif current_user.is_qa?
      params.require(:bug).permit(:title, :description, :bug_category, :image)
    else
      {}
    end
  end 

end
