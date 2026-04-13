class DataController < ApplicationController
    def index
        countries = Employee.pluck(:country).uniq
        job_titles = Employee.pluck(:job_title).uniq
        departments = Employee.pluck(:department).uniq

        render json: {
        countries: countries,
        job_titles: job_titles,
        departments: departments
        }
    end
end
