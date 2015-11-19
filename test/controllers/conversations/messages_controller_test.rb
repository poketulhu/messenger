require 'test_helper'

class Conversations::MessagesControllerTest < ActionController::TestCase
  test "POST #create" do
    #assert_difference('Message.count') do
    #  post :create, conversation_id: conversations(:one), params: { message: { body: 'Some text' } }, format: :json
    #end
    post :create, conversation_id: conversations(:one), format: :json
    assert_response :success
  end

  test "GET #index" do
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
