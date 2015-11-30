class SessionsController < ApplicationController
  def create
    user_name = params[:session][:name]
    user = user_name.present? && User.find_by(name: user_name)
    auth_header = "Token token=\"#{user.auth_token}\"" unless user == nil
    if user && auth_header == request.headers['Authorization']
      session[:current_user_id] = user.id
      render json: user, status: :ok
    else
      render json: { errors: "Invalid name" }, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user = session[:current_user_id] = nil
    head 204
  end
end
