class ConversationsController < ApplicationController
  respond_to :json

  def index
    conversation=Conversation.all
    render json: conversation
  end

  def create
    @conversation=Conversation.conversation_exists(conversation_params)

    if @conversation.save
      render json: @conversation.id, status: 201
    else
      render json: { errors: conversation.errors }, status: 422
    end
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
