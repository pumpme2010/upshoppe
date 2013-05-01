class AddImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    User.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password', :admin=> true,:shopname => 'the penis')
  end
end
