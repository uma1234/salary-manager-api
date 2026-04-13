class SalaryAnalytics
    def self.country_stats(country)
        scope = Employee.where(country: country)

        {
        min: scope.minimum(:salary)&.to_f,
        max: scope.maximum(:salary)&.to_f,
        avg: scope.average(:salary)&.to_f
        }
    end

    # def self.avg_salary_by_job(country, job_title)
    #     Employee.where(country: country, job_title: job_title)
    #             .average(:salary)&.to_f
    # end

    def self.department_breakdown(country)
        Employee.where(country: country)
                .group(:department)
                .average(:salary).transform_values { |v| v.to_f }
    end

    def self.department_headcount(country)
        Employee.where(country: country)
            .group(:department)
            .count
    end
    def self.avg_salary_by_job(country, job_title)
        avg = Employee
                .where("LOWER(country) = ? AND LOWER(job_title) = ?",
                        country.to_s.strip.downcase,
                        job_title.to_s.strip.downcase)
                .average(:salary)

        avg ? avg.to_f : 0
    end
            
end