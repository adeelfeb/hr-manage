class EmployeesController < ApplicationController

    before_action :set_employee, only: [:edit, :show, :destroy, :update] 
  def index
        @employees = Employee.all
    end

    def new
    @employee = Employee.new
    end


    def show
    end

    def destroy
        if @employee.destroy
            redirect_to employees_path, notice: "Emplyee Has been destroyed"
        end
    end


    def create
        @employee = Employee.new(employee_params)
        if @employee.save
        redirect_to employees_path, notice: "Employee created successfully!"
        else
        render :new, status: :unprocessable_entity
        end
    end


    def edit 
    end
  
    def update
        if(@employee.update(employee_params))
            redirect_to employees_path, notice: "Employee data updated"
        else
            redner :edit 
        end
    end


    private   

    def set_employee
        @employee = Employee.find(params[:id])
    rescue ActiveRecord:: RecordNotFound => error
        redirect_to employees_path, notice: "Employee Not Found"
    end


  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :city, :address, :phone)
  end
end
