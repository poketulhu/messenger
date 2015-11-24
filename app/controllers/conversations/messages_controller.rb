class Conversations::MessagesController < ApplicationController
  respond_to :json
  before_action :find_conversation, :only => [:index, :create]
  before_action :authenticate

  def index
    messages=@conversation.messages.page(params[:page]).per(params[:per_page])
    mark_as_read(messages)
    render json: messages, meta: { pagination:
                                   { per_page: params[:per_page],
                                     total_pages: messages.total_pages,
                                     total_objects: messages.total_count } }
  end

  def create
    @message = @conversation.messages.build(message_params)
    @message.user_id = @current_user.id
    if @message.save
      render json: @message, status: :created
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end

  def show
    @message = Message.find params[:id]
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end

    def find_conversation
      @conversation = Conversation.user_conversations(@current_user).find(params[:conversation_id])
    end

    def mark_as_read(messages)
      @conversation.messages.each do |message|
        message.read_at = Time.now
        message.save
        @conversation.unread = nil
        @conversation.save
      end
    end
end
