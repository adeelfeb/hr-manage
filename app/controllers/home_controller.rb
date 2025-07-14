class HomeController < ApplicationController
  def index
    @sub_heading = "Welcome to the HR Management System"
    @title = "HR Management Home"
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
