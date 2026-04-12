class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :country
      t.decimal :salary
      t.integer :age
      t.string :department
      t.string :email

      t.timestamps
    end
    # Indexes for performance
    add_index :employees, :country
    add_index :employees, :job_title
    add_index :employees, :email, unique: true
  end
end
