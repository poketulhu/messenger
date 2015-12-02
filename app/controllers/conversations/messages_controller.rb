class Conversations::MessagesController < ConversationsController
  respond_to :json
  before_action :find_conversation
  before_action :authenticate

  def index
    messages = @conversation.messages.deleted.page(params[:page]).per(params[:per_page])
    mark_as_read(messages)
    render json: messages, meta: { pagination:
                                   { per_page: params[:per_page],
                                     total_pages: messages.total_pages,
                                     total_objects: messages.total_count } }
  end

  def create
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    if @message.save
      render json: @message, status: :created
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end

  def update
    @message = @conversation.messages.find_by_id(params[:id])
    if @message.update(message_params)
      render json: @message, status: 200
    else
      render json: { errors: product.errors }
    end
  end

  def destroy
    @message = @conversation.messages.find_by_id(params[:id])
    @message.mark_as_deleted(current_user)
    @message.save
    render json: current_user.messages.deleted, status: :ok
  end

  def search
    MessagesIndex.import
    id = params[:conversation_id]
    if params[:q]
      @messages = MessagesIndex.query(match: query_type(params[:q])).filter{ conversation_id == id }.load
      #query_type defined in messages_helper.rb
      render json: @messages, status: :ok
    else
      @messages = []
      render json:{ errors: "Messages not found" }, status: :unprocessable_entity
    end
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end

    def find_conversation
      @conversation = Conversation.user_conversations(current_user).find(params[:conversation_id])
    end

    def mark_as_read(messages)
      @conversation.messages.each do |message|
        message.touch(:read_at)
        @conversation.unread = 0
        @conversation.save
      end
    end
end
