# app/controllers/projects_controller.rb

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_project, only: %i[edit update destroy]

  # def index
  #   @projects = policy_scope(Project)
  #   # @projects = Project.all

  # end
  def index
    if current_user.is_manager?
      @projects = Project.where(user_id: current_user.id)
    else
      @projects = current_user.assigned_projects
    end
  end

  def show
    @project = Project.find(params[:id])

    @bugs =
      if current_user.is_developer?
        @project.bugs
                .joins(:developers)
                .where(users: { id: current_user.id })
                .distinct
      elsif current_user.is_qa?
        @project.bugs.where(user_id: current_user.id)
      elsif current_user.is_manager?
        @project.bugs
      else
        @bugs = Bug.none
      end
  end


  # def show
  #   @project = Project.find(params[:id])
  #   authorize @project

  #   # Show only relevant bugs based on role
  #   @bugs = if current_user.is_developer?
  #             @project.bugs.where(developer_id: current_user.id)
  #           elsif current_user.is_qa?
  #             @project.bugs.where(user_id: current_user.id)
  #           else
  #             @project.bugs
  #           end
  # end




  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = current_user.created_projects.build(project_params)

    authorize @project
    if @project.save
      redirect_to @project, notice: 'Project created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    new_user_ids = Array(project_params[:user_ids]).reject(&:blank?).map(&:to_i)
    existing_user_ids = @project.user_ids

    combined_user_ids = (existing_user_ids + new_user_ids).uniq

    if @project.update(project_params.except(:user_ids))
      @project.user_ids = combined_user_ids
      redirect_to @project, notice: 'Project updated successfully.'
    else
      render :edit
    end
  end


  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project deleted.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_project
    authorize @project
  end

  def project_params
    params.require(:project).permit(:title, :description, user_ids: [])
  end

end
