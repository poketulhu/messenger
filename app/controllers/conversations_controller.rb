class ConversationsController < ApplicationController
  respond_to :json

  def index
    conversation=Conversation.all
    render json: conversation
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    render json: { conversation_id: @conversation.id }
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
