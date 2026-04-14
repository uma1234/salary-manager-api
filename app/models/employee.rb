class Employee < ApplicationRecord
  validates :first_name,  presence: true,format: { with: /\A[a-zA-Z]+\z/, message: "must contain only letters" }
  validates :last_name,  presence: true,format: {with: /\A[a-zA-Z]+\z/, message: "must contain only letters"}
  validates :email, presence: true, format: {
    with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/,
    message: "must be a valid email format"
  }
  validates :salary, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :job_title, :country, :salary, :department, presence: true

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