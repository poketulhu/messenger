ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/spec"

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # fixtures :all

  def setup_for_conversations
    @sender = User.create(name: 'First')
    @recipient = User.create(name: 'Second')
    @another_user = User.create(name: 'Third')
    @conversation = Conversation.create(sender_id: @sender.id, recipient_id: @recipient.id, unread: 0)
    @another_conversation = Conversation.create(sender_id: @recipient.id, recipient_id: @another_user.id, unread: 2)
    @auth_header = "Token token=#{@sender.auth_token}"
    @token = ActionController::HttpAuthentication::Token.encode_credentials(@sender.auth_token)
  end

  def setup_for_messages
    @sender = User.create(name: 'Sender')
    @conversation = Conversation.create(sender_id: @sender.id, recipient_id: 2, unread: 0)
    @token = ActionController::HttpAuthentication::Token.encode_credentials(@sender.auth_token)
    @message = Message.create(body: "Some text", conversation_id: @conversation.id, user_id: @sender.id)
  end

  def log_in
    setup_for_messages
    session[:current_user_id] = @sender.id
    request.headers['Authorization'] = @token
  end

end
