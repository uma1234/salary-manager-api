require 'rails_helper'

RSpec.describe "Data API", type: :request do
  describe "GET /data" do
    it "returns unique countries, job_titles and departments" do
      Employee.create!(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        job_title: "Developer",
        country: "India",
        salary: 50000,
        department: "IT"
      )

      Employee.create!(
        first_name: "Alice",
        last_name: "Smith",
        email: "alice@example.com",
        job_title: "Manager",
        country: "USA",
        salary: 60000,
        department: "HR"
      )

      get "/data"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["countries"]).to match_array(["India", "USA"])
      expect(json["job_titles"]).to match_array(["Developer", "Manager"])
      expect(json["departments"]).to match_array(["IT", "HR"])
    end
  end
end