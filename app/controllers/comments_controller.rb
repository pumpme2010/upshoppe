class CommentsController < ApplicationController
  def index
    #queries all comments for specific product
    @product = Product.find(params[:product_id])
    @comment = @product.comments.all
  end


def create
  #creates a new comment from product view
  @product = Product.find(params[:product_id])
    @comment = @product.comments.build(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@product, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { redirect_to(@product, :notice => 
        'Comment could not be saved.')}
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    #delete comment admin only
    @comment = Comment.find(params[:id])
    if @comment.destroy
      msg = "deleted na, pagcriminal case na"
    else
      msg = "di mada bai"
    end
    if current_user.admin
      redirect_to admin_comments_path, :notice => msg
    end
  end

end
