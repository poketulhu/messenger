require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "GET #index" do
    get :index, { format: :json }
    assert_response :success
    body = JSON.parse(response.body)
    assert_includes body, "users"
  end
end
