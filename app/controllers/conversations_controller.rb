class ConversationsController < ApplicationController
  before_action :authenticate
  respond_to :json

  def index
    conversations = @current_user.conversations

    render json: conversations
  end

  def create
    @conversation = Conversation.conversation_exists(conversation_params)
    if @conversation.save
      render json: @conversation.id, status: :created
    else
      render json: { errors: conversation.errors }, status: :unprocessable_entity
    end
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
