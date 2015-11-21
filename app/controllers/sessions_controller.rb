class SessionsController < ApplicationController
  def create
    user_name = params[:session][:name]
    user = user_name.present? && User.find_by(name: user_name)
    if user
      sign_in user
      render json: user, status: :ok
    else
      render json: { errors: "Invalid name" }, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    head 204
  end
end
