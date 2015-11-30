class ApplicationController < ActionController::Base
  include AuthenticationHelper

  protect_from_forgery with: :exception

  after_action :set_online

  private
    def current_user
      @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
    end

    def set_online
      if !!current_user #not nil and not false
        $redis_onlines.set( current_user.id, nil, ex: 10*60 )
      end
    end
end
