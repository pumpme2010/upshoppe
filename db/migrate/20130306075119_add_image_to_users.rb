class AddImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    
  end

  def migrate
  	User.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password', :admin=> true)
  end
end
