require 'test_helper'

class Conversations::MessagesControllerTest < ActionController::TestCase
  setup do
    @sender = User.create(name: 'Sender')
    @conversation = Conversation.create(sender_id: @sender.id, recipient_id: 2)
    @auth_header = "Token token=#{@sender.auth_token}"
    @token = ActionController::HttpAuthentication::Token.encode_credentials(@sender.auth_token)
  end

  test "POST #create" do
    request.headers['Authorization'] = @token
    assert_difference('Message.count') do
      post :create, conversation_id: Conversation.first, params: { message: { body: 'Some text' } }, format: :json
    end

  end

  test "GET #index" do
    request.headers['Authorization'] = @token
    get :index, conversation_id: conversations(:one), format: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_includes body, "messages"
    assert_includes body, "meta"
    assert_includes body["meta"], "pagination"
    assert_includes body["meta"]["pagination"], "per_page"
    assert_includes body["meta"]["pagination"], "total_pages"
    assert_includes body["meta"]["pagination"], "total_objects"
  end
end
