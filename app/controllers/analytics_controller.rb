class AnalyticsController < ApplicationController
  def country
    render json: SalaryAnalytics.country_stats(params[:country])
  end

  def job
    render json: {
      avg_salary: SalaryAnalytics.avg_salary_by_job(params[:country], params[:job_title])
    }
  end

  def department
    render json: SalaryAnalytics.department_breakdown(params[:country])
  end
  
end