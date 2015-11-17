require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase
  test "GET #index" do
    get :index, format: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_includes body, "conversations"
    assert_includes body["conversations"], {"participants_names"=>"David, Steve"}
  end

  test "POST #create" do
    post :create, format: :json
    assert_response :success
  end
end
