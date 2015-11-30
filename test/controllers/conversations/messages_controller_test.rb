require 'test_helper'

class Conversations::MessagesControllerTest < ActionController::TestCase
  test "POST #create" do
    log_in
    assert_difference('Message.count') do
      post :create, conversation_id: @conversation.id, message: { body: 'Some text' }, format: :json
    end
  end

  test "GET #index" do
    log_in
    get :index, conversation_id: @conversation.id, format: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_includes body, "messages"
    assert_includes body, "meta"
    assert_includes body["meta"], "pagination"
    assert_includes body["meta"]["pagination"], "per_page"
    assert_includes body["meta"]["pagination"], "total_pages"
    assert_includes body["meta"]["pagination"], "total_objects"
  end

  test "PATCH/PUT #update" do
    log_in
    patch :update, conversation_id: @conversation, id: @message.id, message: { body: "Some new text" }, format: :json
    assert_response :success
  end

  test "DELETE #destroy" do
    log_in
    delete :destroy, { conversation_id: @conversation.id, id: @message.id }, format: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal [], body["messages"]
  end

  # test "#search" do
  #   log_in
  #   get :search, user_id: @sender.id, q: "text", format: :json
  #   assert_response :success
  # end
end
