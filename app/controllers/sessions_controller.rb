# Unlike the Users resource, which uses a database back-end (via the User model)
# to persist data, the Sessions resource will use cookies, and much of the work
# involved in login comes from building this cookie-based authentication machinery

class SessionsController < ApplicationController

  # render the log in form
  def new
  end

  # create a new session
  # find user by session-email and authenticate user by session-password
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      # remember or forget depending on the checkbox
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user  # redirect to the user's profile page
    else
      # show an error message and re-render the login form
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # delete a session
  def destroy
    log_out if user_logged_in?
    redirect_to root_url
  end
end
