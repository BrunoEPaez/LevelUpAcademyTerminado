class AddYoutubeIdToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :youtube_id, :string
  end
end
