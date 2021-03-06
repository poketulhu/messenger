require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user=User.create(name: 'Username')
    session[:current_user_id] = @user.id
    @token = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)
    request.headers['Authorization'] = @token
  end

  test 'POST #create with correct credentials' do
    credentials = { name: @user.name }
    post :create, { session: credentials }
    assert_response :success, "Session with correct credentials"
  end

  test 'POST #create with wrong credentials' do
    wrong_credentials = {name: "fake"}
    post :create, { session: wrong_credentials }
    assert_response :unprocessable_entity, "Session with correct credentials"
  end

  test 'DELETE #destroy' do
    delete :destroy, id: @user.auth_token
    assert_response :no_content
  end
end
