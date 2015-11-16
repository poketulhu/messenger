class MessagesController < ApplicationController
  respond_to :json

  def index
    conversation = Conversation.find(params[:conversation_id])
    messages=conversation.messages.page(params[:page]).per(20)
    render json: messages, meta: { pagination:
                                   { per_page: params[:per_page],
                                     total_pages: messages.total_pages,
                                     total_objects: messages.total_count } }
  end

  def create
    conversation = Conversation.find(params[:conversation_id])
    @message = conversation.messages.create(message_params)
    @message.user_id = current_user.id
    @message.save

    render json: @message
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
