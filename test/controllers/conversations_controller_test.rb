require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase
  setup do
    setup_for_conversations
  end

  test "GET #index" do
    request.headers['Authorization'] = @token
    get :index, { format: :json }
    assert_response :success
    body = JSON.parse(response.body)
    assert_includes body, "conversations"
    #assert_includes body["conversations"], {"participants_names"=>"#{@sender.name}, #{@recipient.name}"}
    #assert_not_includes body["conversations"], {"participants_names"=>"#{@recipient.name}, #{@another_user.name}"}
  end

  test "POST #create" do
    request.headers['Authorization'] = @token
    post :create, format: :json
    assert_response :success
  end
end
