class AddAvatarBase64ToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :avatar_base64, :text
  end
end
