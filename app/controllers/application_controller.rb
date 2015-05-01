class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def hello
    render text: "こんにちは、世界のみなさん"
  end

  private

    # Confirms if a user is logged in.
    # Requires login if not already logged in.
    def logged_in_user
      unless user_logged_in?
        store_location  # For friendly forwarding.
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
