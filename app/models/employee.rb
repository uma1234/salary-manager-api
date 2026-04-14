class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :job_title, :country, :salary, :department, presence: true
  validates :salary, numericality: { greater_than: 0 }

  scope :search, ->(query) {
    return all if query.blank?

    pattern = "%#{query}%"

    where(
      "first_name LIKE :q OR last_name LIKE :q OR email LIKE :q OR job_title LIKE :q OR department LIKE :q OR country LIKE :q",
      q: pattern
    )
  }

  def self.paginate(page)
    page_number = page.presence || 1
    page(page_number).per(10)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end