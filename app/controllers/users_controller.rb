class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def public_users
    #queries all users or searched. along with pagination
    @users = User.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    #queries the user along with his products
  	@user = User.find(params[:id])
    @products = Product.where(:user_id => @user.id)
    #provides message form
    @message = Message.new
  end

  def destroy

    @user = User.find(params[:id])
    if @user.destroy
      msg = "deleted"
    else
      msg = "failure"
    end
    if current_user.admin
      redirect_to admin_users_path, :notice => msg
    else
      redirect_to users_public_users_path, :notice => msg
    end
  end


  def edit
        @user = User.find(params[:id])
    end
    
  def update
      @user = User.find(params[:id])
      if(@user.update_attributes(params[:user]))
          redirect_to user_path(@user), :notice => "Your account has been updated"
      else
          render "edit"
      end
  end

  def new
    #for sign up form. with some news
  	@user = User.new
    @products = Product.order("created_at DESC").limit(10)
    @comments = Comment.order("created_at DESC").limit(10)
    @popular = Like.find_by_sql("SELECT product_id, count(product_id) as num, name FROM likes LEFT JOIN products ON products.id = likes.product_id GROUP BY product_id ORDER BY num DESC LIMIT 10")	
  end

  def create
  	@user = User.new(params[:user])
    @products = Product.order("created_at DESC").limit(10)
    @comments = Comment.order("created_at DESC").limit(10)
    @popular = Like.find_by_sql("SELECT product_id, count(product_id) as num, name FROM likes LEFT JOIN products ON products.id = likes.product_id GROUP BY product_id ORDER BY num DESC LIMIT 10")
  	if @user.save
  		redirect_to new_session_path, :notice => "Signed up!"
  	else
  		render "new"
  	end
  end
end
