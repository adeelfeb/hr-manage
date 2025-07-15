class EmployeesController < ApplicationController
    def index
        @employees = Employee.all
    end

    def update
    end
end