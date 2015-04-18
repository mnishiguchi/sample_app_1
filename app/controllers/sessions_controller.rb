# Unlike the Users resource, which uses a database back-end (via the User model)
# to persist data, the Sessions resource will use cookies, and much of the work
# involved in login comes from building this cookie-based authentication machinery

class SessionsController < ApplicationController

  # Renders the login form.
  def new
  end

  # Creates a new session based on the login form.
  # Finds user by email(lower case) and authenticates it by password.
  # Rejects non-activated user.
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        remember_or_forget
        redirect_back_or @user  # Friendly forwarding or profile page.
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # Delete a session.
  def destroy
    log_out if user_logged_in?
    redirect_to root_url
  end

  #----------------------------------------------------------------------------
  private

    # Remembers user for persistent session if the checkbox is checked.
    def remember_or_forget
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
    end
end
