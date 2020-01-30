class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
      redirect_to login_path unless current_user
    end

    def set_time_zone 
      Time .zone = current_user.time_zone
    end 
end
