class AddInstructorToJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :jobs, :instructor, :string
  end
end
