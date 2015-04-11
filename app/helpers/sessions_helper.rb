module SessionsHelper

  # We can treat Rails' built-in session method as if it were a hash.
  # The assigned value will be encrypted and placed as a temporary cookie on the
  # user’s browser.
  # The temporary cookie allows us to retrieve the id on subsequent pages using
  # session[:user_id].

  # log in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # return true if the user is logged in, false otherwise
  def user_logged_in?
    !current_user.nil?
  end

  # log out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # remember a user in a persistent session
  def remember(user)
    user.save_remember_digest
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # forget a persistent session
  def forget(user)
    user.delete_remember_digest
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 1. if current user is already assigned, just return it
  # 2. if session exists, find user and return it as current user
  # 3. if persistent cookies exist, find user, authenticate it, return it as current user
  def current_user
    # the current logged-in user (if any)
    if !!(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)

    # the user corresponding to the remember token cookie (if any)
    elsif !!(user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticate_with_token(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
end
