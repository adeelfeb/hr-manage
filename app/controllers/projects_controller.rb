# app/controllers/projects_controller.rb

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_project, only: %i[edit update destroy]

  def index
    @projects = policy_scope(Project)
  end

  def show
    @project = Project.find(params[:id])
  end


  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = current_user.projects.build(project_params)
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
