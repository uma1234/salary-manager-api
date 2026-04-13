RSpec.describe SalaryAnalytics do
    describe ".country_stats" do
        before do
        Employee.create!(country: "India", job_title: "Engineer", department: "Tech", salary: 100000)
        Employee.create!(country: "India", job_title: "Engineer", department: "Tech", salary: 200000)
        Employee.create!(country: "India", job_title: "HR", department: "People", salary: 150000)

        Employee.create!(country: "USA", job_title: "Engineer", department: "Tech", salary: 300000)
        end

        it "returns minimum salary for a country" do
        result = described_class.country_stats("India")

        expect(result[:min]).to eq(100000)
        end

        it "returns maximum salary for a country" do
        result = described_class.country_stats("India")

        expect(result[:max]).to eq(200000)
        end

        it "returns average salary for a country" do
        result = described_class.country_stats("India")

        expect(result[:avg]).to eq(150000.0)
        end

        it "excludes employees from other countries" do
        result = described_class.country_stats("India")

        expect(result[:max]).not_to eq(300000)
        end

        it "returns nil values when no employees exist" do
        result = described_class.country_stats("Germany")

        expect(result).to eq({ min: nil, max: nil, avg: nil })
        end
    end

    #avg_salary_by_job
    describe ".avg_salary_by_job" do
        before do
        Employee.create!(country: "India", job_title: "Engineer", department: "Tech", salary: 100_000)
        Employee.create!(country: "India", job_title: "Engineer", department: "Tech", salary: 200_000)
        Employee.create!(country: "India", job_title: "HR", department: "People", salary: 150_000)

        Employee.create!(country: "USA", job_title: "Engineer", department: "Tech", salary: 300_000)
        end

        it "returns average salary for a job title in a country" do
        result = described_class.avg_salary_by_job("India", "Engineer")

        expect(result).to eq(150000.0)
        end

        it "returns nil when job title does not exist in country" do
        result = described_class.avg_salary_by_job("India", "Doctor")

        expect(result).to be_nil
        end

        it "does not mix employees from other countries" do
        result = described_class.avg_salary_by_job("USA", "Engineer")

        expect(result).to eq(300000.0)
        end
    end

    #department_breakdown
    describe ".department_breakdown" do
        before do
            Employee.create!(country: "India", job_title: "Engineer", department: "Tech", salary: 100_000)
            Employee.create!(country: "India", job_title: "Engineer", department: "Tech", salary: 200_000)
            Employee.create!(country: "India", job_title: "HR", department: "People", salary: 150_000)

            Employee.create!(country: "USA", job_title: "Engineer", department: "Tech", salary: 300_000)
        end

        it "returns average salary grouped by department" do
            result = described_class.department_breakdown("India")

            expect(result["Tech"]).to eq(150000.0)
            expect(result["People"]).to eq(150000.0)
        end

        it "returns only departments for given country" do
            result = described_class.department_breakdown("USA")

            expect(result.keys).to eq(["Tech"])
        end

        it "returns empty hash when no employees exist for country" do
            result = described_class.department_breakdown("Germany")

            expect(result).to eq({})
        end
    end
    
end