class AddPathToCourses < ActiveRecord::Migration[8.1]
  def change
    add_reference :courses, :path, null: false, foreign_key: true
  end
end
