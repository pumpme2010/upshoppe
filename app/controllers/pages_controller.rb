class PagesController < ApplicationController
	def about

	end
  def public_products
    #could have been products index. 
    @products = Product.all
  end

  def newsfeed
    #queries latest events with limit of 10
  	@products = Product.order("created_at DESC").limit(10)
  	@comments = Comment.order("created_at DESC").limit(10)
  end

  def search
    #queries from products, users and tags according to search
    @products = Product.search(params[:search])
    @users = User.search(params[:search])
    @tags = Product.searchtag(params[:search])
  end

  def tag
    #finds all products with searched tag
    @tags = Product.where(:tag => params[:tagname])
  end
end
