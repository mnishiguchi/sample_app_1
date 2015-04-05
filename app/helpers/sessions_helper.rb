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
end
