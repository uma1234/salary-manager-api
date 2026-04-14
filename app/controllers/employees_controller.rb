class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # def index
  #   employees = Employee.page(params[:page] || 1).per(10)
  #   render json: employees
  # end
  def index
    employees = Employee.all

    # Apply search if present
    if params[:search].present?
      search = "%#{params[:search]}%"

      employees = employees.where(
        "first_name LIKE :s OR last_name LIKE :s OR email LIKE :s OR job_title LIKE :s OR department LIKE :s OR country LIKE :s",
        s: search
      )
    end

    # Apply pagination AFTER search
    employees = employees.page(params[:page] || 1).per(10)

    render json: employees
  end

  def show
    render json: @employee
  end

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :email,
      :job_title, :country, :salary, :department
    )
  end

  def record_not_found
    render json: { error: "Employee not found" }, status: :not_found
  end
end