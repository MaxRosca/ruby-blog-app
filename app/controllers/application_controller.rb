class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include ActionController::Cookies

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  private
    def authenticate_user
      redirect_to log_in_path unless current_user
    end
end
