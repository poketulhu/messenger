module AuthenticationHelper
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(auth_token: token)
    end
  end
end