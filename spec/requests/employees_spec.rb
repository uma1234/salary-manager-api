require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  describe "GET /employees" do
    it "returns all employees" do
      3.times do |i|
        Employee.create!(
          first_name: "User#{i}",
          last_name: "Test",
          email: "user#{i}@example.com",
          job_title: "Dev",
          country: "India",
          salary: 50000,
          department: "IT",
        )
      end

      get "/employees"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe "POST /employees" do
    it "creates an employee" do
      post "/employees", params: {
        employee: {
          first_name: "John",
          last_name: "Doe",
          email: "john@example.com",
          job_title: "Dev",
          country: "India",
          salary: 60000,
          department: "IT"
        }
      }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["email"]).to eq("john@example.com")
    end
  end

  describe "GET /employees/:id" do
    it "returns a single employee" do
      employee = Employee.create!(
        first_name: "John",
        last_name: "Doe",
        email: "john_show@example.com",
        job_title: "Dev",
        country: "India",
        salary: 60000,
        department: "IT"
      )

      get "/employees/#{employee.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["email"]).to eq("john_show@example.com")
    end
  end

  describe "PUT /employees/:id" do
    it "updates an employee" do
      employee = Employee.create!(
        first_name: "Old",
        last_name: "Name",
        email: "old@example.com",
        job_title: "Dev",
        country: "India",
        salary: 50000,
        department: "IT"
      )

      put "/employees/#{employee.id}", params: {
        employee: {
          first_name: "Updated"
        }
      }

      expect(response).to have_http_status(:ok)
      expect(employee.reload.first_name).to eq("Updated")
    end
  end

  describe "DELETE /employees/:id" do
    it "deletes an employee" do
      employee = Employee.create!(
        first_name: "Delete",
        last_name: "Me",
        email: "delete@example.com",
        job_title: "Dev",
        country: "India",
        salary: 50000,
        department: "IT"
      )

      delete "/employees/#{employee.id}"

      expect(response).to have_http_status(:no_content)
      expect(Employee.exists?(employee.id)).to be_falsey
    end
  end

end