Employee.delete_all

job_titles = ['Engineer', 'Manager', 'Designer', 'Analyst']
countries = ['USA', 'India', 'UK', 'Germany']
departments = ['HR', 'Tech', 'Sales', 'Marketing']

first_names = File.readlines(Rails.root.join("db/first_names.txt")).map(&:strip)
last_names  = File.readlines(Rails.root.join("db/last_names.txt")).map(&:strip)

employees = []

10_000.times do |i|
  first_name = first_names.sample
  last_name  = last_names.sample

  employees << {
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}.#{i}@example.com",
    job_title: job_titles.sample,
    country: countries.sample,
    salary: rand(50_000..200_000),
    department: departments.sample,
    created_at: Time.current,
    updated_at: Time.current
  }
end

Employee.insert_all(employees)

puts "Seeded 10,000 employees successfully!"