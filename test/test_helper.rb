ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/spec"

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  def setup_for_conversations
    @sender = User.create(name: 'First')
    @recipient = User.create(name: 'Second')
    @another_user = User.create(name: 'Third')
    @conversation = Conversation.create(sender_id: @sender.id, recipient_id: @recipient.id)
    @conversation2 = Conversation.create(sender_id: @another_user.id, recipient_id: @sender.id)
    @message = Message.create(body: "Text", conversation_id: @conversation.id, user_id: @recipient.id)
    @another_conversation = Conversation.create(sender_id: @recipient.id, recipient_id: @another_user.id, unread: 2)
    @auth_header = "Token token=#{@sender.auth_token}"
    @token = ActionController::HttpAuthentication::Token.encode_credentials(@sender.auth_token)
  end

  def setup_for_messages
    @sender = User.create(name: 'Sender')
    @conversation = Conversation.create(sender_id: @sender.id, recipient_id: 2)
    @token = ActionController::HttpAuthentication::Token.encode_credentials(@sender.auth_token)
    @message = Message.create(body: "Some text", conversation_id: @conversation.id, user_id: @sender.id)
    @new_message = Message.create(body: "Some new text", conversation_id: 2, user_id: 2)
  end

  def log_in
    setup_for_messages
    session[:current_user_id] = @sender.id
    request.headers['Authorization'] = @token
  end

end
