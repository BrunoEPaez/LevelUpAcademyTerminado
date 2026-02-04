class AddDetailsToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :free, :boolean
    add_column :courses, :language, :string
  end
end
