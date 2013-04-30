class AdminController < ApplicationController
	def index
		#provides data for admin newsfeed without limi
  		@products = Product.order("created_at DESC")
  		@comments = Comment.order("created_at DESC")
   		@popular = Like.find_by_sql("SELECT product_id, count(product_id) as num, name FROM likes LEFT JOIN products ON products.id = likes.product_id GROUP BY product_id ORDER BY num DESC")	
	end

	def products
		@products = Product.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
	end

	def users
		@users = User.order('shopname').paginate(:per_page => 10, :page => params[:page])
	end

	def promote
		#promotes a user to admin by updating :admin attribute to true
		@user = User.find(params[:id])
		@user.update_attribute(:admin, true)
		redirect_to admin_users_path, :notice => "Promoted"
	end

	def comments
		@comments = Comment.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
	end

	def messages
		@messages = Message.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
	end
end
