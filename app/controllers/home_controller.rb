class HomeController < ApplicationController

  before_action :authenticate_user!
  include Pundit

  def index
    authorize :home, :show?

    case current_user.user_type
    when "manager"
      @title = "Welcome Manager"
      @sub_heading = "Manager dashboard content"
    when "developer" 
      @title = "Welcome Developer"
      @sub_heading = "Developer dashboard and tasks"
    when "qa"
      @title = "Welcome QA"
      @sub_heading = "QA dashboard and testing tools"
    else
      @title = "Welcome Guest"
      @sub_heading = "General homepage for users"
    end
  end
  
  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :position, :department, :email)
  end
end
