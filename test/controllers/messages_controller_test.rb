require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "POST #create" do
    assert_difference('Message.count') do
      post :create, conversation_id: conversations(:one), params: { message: { body: 'Some text' } }, format: :json
    end
  end

  test "GET #index" do
    get :index, conversation_id: conversations(:one), format: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_includes body, "messages"
  end
end
