require 'test_helper'
require "uri"

class Conversations::MessagesControllerTest < ActionController::TestCase
  test "POST #create" do
    log_in
    assert_difference('Message.count') do
      post :create, conversation_id: @conversation.id, message: { body: "https://pp.vk.me/c543105/v543105319/fa17/Du8hDzArx8Q.jpg" }, format: :json
    end
    assert_difference('Message.count') do
      post :create, conversation_id: @conversation.id, message: { body: "text", image: File.new("/home/dasha/0lVxhR_3sLQ.jpg") }, format: :json
    end
  end

  test "GET #index" do
    log_in
    get :index, conversation_id: @conversation.id, format: :json
    assert_response :success
    body = JSON.parse(response.body)
    p body
    assert_includes body, "messages"
    assert_includes body, "meta"
    assert_includes body["meta"], "pagination"
    assert_includes body["meta"]["pagination"], "per_page"
    assert_includes body["meta"]["pagination"], "total_pages"
    assert_includes body["meta"]["pagination"], "total_objects"
    assert_not_equal nil, @conversation.messages.first.read_at
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
    assert_not_includes body, body["messages"], {"body"=>"Some text", "page_information"=>nil, "image"=>"/images/original/missing.png", "video"=>"/videos/original/missing.png", "created_at"=>"2015-12-03T10:25:10.626Z"}
  end

  test "GET #search" do
    log_in
    get :search, conversation_id: @conversation.id, q: "some", format: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal body["messages"][0]["body"].downcase, "some text"
    assert_not_includes body["messages"], Message.find_by(body: "Some new text")

    get :search, conversation_id: @conversation.id, q: Date.new(2015, 12, 3), format: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal body["messages"][0]["body"], @message.body

    assert_includes body["meta"], "pagination"
  end
end
