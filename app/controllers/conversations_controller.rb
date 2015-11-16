class ConversationsController < ApplicationController
  respond_to :json

  def create
    conversation = Conversation.new(conversation_params)
    if conversation.save
      render json: conversation, status: 201
    else
      render json: { errors: conversation.errors }, status:422
    end
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
