class AddProfileDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :birthdate, :date
    add_column :users, :city, :string
    add_column :users, :bio, :text
    add_column :users, :linkedin_url, :string
    add_column :users, :github_url, :string
  end
end
