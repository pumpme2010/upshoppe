class SessionsController < ApplicationController
  def index
  end

  def new
  	#provides some news to session login
  	@products = Product.order("created_at DESC").limit(10)
    @popular = Like.find_by_sql("SELECT product_id, count(product_id) as num, name FROM likes LEFT JOIN products ON products.id = likes.product_id GROUP BY product_id ORDER BY num DESC LIMIT 10")
  end

  def create
  	#log in
	user = User.authenticate(params[:email], params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to pages_newsfeed_path
  	else
  		flash.now.alert = "Invalid email or password"
      @products = Product.order("created_at DESC").limit(10)
      @comments = Comment.order("created_at DESC").limit(10)
      @popular = Like.find_by_sql("SELECT product_id, count(product_id) as num, name FROM likes LEFT JOIN products ON products.id = likes.product_id GROUP BY product_id ORDER BY num DESC LIMIT 10")
  		render "new"

  	end
  end

  def destroy
  	#log out
	session[:user_id] = nil
	flash.now.alert = "Invalid email or password"
	redirect_to new_session_path
  end
end
