class ConversationsController < ApplicationController
  before_action :authenticate
  respond_to :json

  def index
    conversations = Conversation.user_conversations(current_user)
    unread_messages_count(conversations)
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

    def unread_messages_count(conversations)
      conversations.each do |conversation|
        conversation.unread = conversation.messages.where("read_at IS NULL AND user_id!=?", current_user.id).count
        conversation.save
      end
    end
end
