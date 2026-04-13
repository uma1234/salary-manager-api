require 'rails_helper'

RSpec.describe "Analytics API", type: :request do
  def create_employee(attrs = {})
    Employee.create!({
      first_name: "Test",
      last_name: "User",
      email: "test#{SecureRandom.hex(4)}@example.com",
      country: "India",
      job_title: "Engineer",
      department: "Tech",
      salary: 100000
    }.merge(attrs))
  end

  describe "GET /analytics/country" do
    before do
      create_employee(salary: 100000, country: "India")
      create_employee(salary: 200000, country: "India")
      create_employee(salary: 300000, country: "USA")
    end

    it "returns min, max, avg salary for country" do
      get "/analytics/country", params: { country: "India" }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["min"]).to eq(100000)
      expect(json["max"]).to eq(200000)
      expect(json["avg"]).to eq(150000.0)
    end
  end

  describe "GET /analytics/job" do
    before do
      create_employee(job_title: "Engineer", salary: 100000)
      create_employee(job_title: "Engineer", salary: 200000)
      create_employee(job_title: "HR", salary: 150000)
    end

    it "returns average salary for job title in country" do
      get "/analytics/job", params: { country: "India", job_title: "Engineer" }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["avg_salary"]).to eq(150000.0)
    end
  end

  describe "GET /analytics/department" do
    before do
      create_employee(job_title: "Engineer", department: "Tech", salary: 100000)
      create_employee(job_title: "HR", department: "People", salary: 150000)
      create_employee(country: "USA", job_title: "Engineer", department: "Tech", salary: 300000)
    end

    it "returns department breakdown for country" do
      get "/analytics/department", params: { country: "India" }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["Tech"]).to eq(100000.0)
      expect(json["People"]).to eq(150000.0)

      expect(json["USA"]).to be_nil
    end
  end
end