require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:valid_employee) do
    Employee.new(
      first_name: "John",
      last_name: "Doe",
      email: "john@example.com",
      job_title: "Developer",
      country: "India",
      salary: 50000
    )
  end

  it "is valid with all attributes" do
    expect(valid_employee).to be_valid
  end

  it "is invalid without first_name" do
    employee = valid_employee
    employee.first_name = nil

    expect(employee).not_to be_valid
    expect(employee.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without last_name" do
    employee = valid_employee
    employee.last_name = nil

    expect(employee).not_to be_valid
  end

  it "is invalid without country" do
    employee = valid_employee
    employee.country = nil

    expect(employee).not_to be_valid
  end

  it "returns full name" do
    employee = Employee.new(first_name: "John", last_name: "Doe")

    expect(employee.full_name).to eq("John Doe")
  end
end