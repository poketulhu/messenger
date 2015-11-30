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
    assert_includes body, "conversations"
    assert_includes body["conversations"], {"participants_names"=>[@sender.name, @recipient.name],
                                            "unread_count"=>@conversation.unread}
    assert_not_includes body["conversations"], {"participants_names"=>[@recipient.name, @another_user.name],
                                                "unread_count"=>@another_conversation.unread}
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
