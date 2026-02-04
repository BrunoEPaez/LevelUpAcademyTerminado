class AddExtraFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :portfolio_url, :string
  end
end
