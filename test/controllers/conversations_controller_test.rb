require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase
  setup do
    setup_for_conversations
  end

  test "GET #index" do
    session[:current_user_id] = @sender.id
    request.headers['Authorization'] = @token
    get :index, { format: :json }
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal body["conversations"][1]["participants_names"], [@sender.name, @recipient.name]
    assert_not_includes body["conversations"][1]["participants_names"], [@recipient.name, @another_user.name]
    assert_equal [{"participants_names"=>[@another_user.name, @sender.name],
                   "unread_count"=>0},
                  {"participants_names"=>[@sender.name, @recipient.name],
                   "unread_count"=>1}], body["conversations"]
  end

  test "POST #create" do
    session[:current_user_id] = @sender.id
    request.headers['Authorization'] = @token
    assert_difference('Conversation.count') do
      post :create, format: :json
    end
    assert_response :success
  end
end
