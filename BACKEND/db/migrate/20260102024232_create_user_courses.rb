class CreateUserCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :user_courses do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :course_id
      t.boolean :completed
      t.boolean :favorite

      t.timestamps
    end
  end
end
