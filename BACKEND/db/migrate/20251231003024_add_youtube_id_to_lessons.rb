class AddYoutubeIdToLessons < ActiveRecord::Migration[8.1]
  def change
    add_column :lessons, :youtube_id, :string
  end
end
