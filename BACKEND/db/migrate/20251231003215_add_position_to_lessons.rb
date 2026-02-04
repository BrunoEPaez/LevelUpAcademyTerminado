class AddPositionToLessons < ActiveRecord::Migration[8.1]
  def change
    add_column :lessons, :position, :integer
  end
end
