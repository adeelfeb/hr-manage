class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_bug, only: %i[edit update]
  before_action :authorize_bug_creation, only: [:new, :create]


  def index
    @bugs = @project.bugs
  end

  def new
    @bug = @project.bugs.build
  end

  def update
    if @bug.update(bug_params)
      redirect_to project_path(@bug.project), notice: "Bug updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def create
    @bug = @project.bugs.build(bug_params)
    @bug.user = current_user  # the QA who reported the bug

    if @bug.save
      redirect_to project_path(@project), notice: "Bug created successfully."
    else
      render :new
    end
  end

  private

  

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
    params.require(:bug).permit(:title, :description, :bug_category, :progress_state, :deadline, :developer_id, :image)
  end
end
