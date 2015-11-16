class MessagesController < ApplicationController
  respond_to :json

  def index
    messages=Message.all
    render json: messages
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save

    render json: message
  end

  #def show
  #  @conversation = Conversation.find(params[:conversation_id])
  #  respond_with conversation.messages.find(params[:id])
  #end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
