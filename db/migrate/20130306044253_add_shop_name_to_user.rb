class AddShopNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :shopname, :string
  end
end
