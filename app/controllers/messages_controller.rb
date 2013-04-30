class MessagesController < ApplicationController
  def index
    #query messages sent to the user
    @messages = Message.where(:sendto_id => current_user.id).order(:sender_id).paginate(:per_page => 10, :page => params[:page])
    #query number of messages recieved 24 hours ago
    @nummsg = @messages.where("created_at > ?", 24.hours.ago).count
  end

  def outbox
    #get messages that you send to other users
    @messages = Message.where(:sender_id => current_user.id).order(:sendto_id).paginate(:per_page => 10, :page => params[:page])
  end

  def create
  	@message = Message.new(params[:message])

    if @message.save
      msg = 'message was successfully sent.'
    else
      msg = 'message was not sent.'
    end
    redirect_to user_path(@message.sendto_id), notice: msg
  end

  def destroy
    @message = Message.find(params[:id])
    
    if @message.destroy
      msg = 'message was successfully deleted.'
    else
      msg = 'message could not be deleted.'
    end
    if current_user.admin
      redirect_to admin_messages_path, notice: msg
    else
      redirect_to user_messages_path(current_user.id), notice: msg
    end
  end


end
