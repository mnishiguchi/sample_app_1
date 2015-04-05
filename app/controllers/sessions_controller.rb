
# Unlike the Users resource, which uses a database back-end (via the User model)
# to persist data, the Sessions resource will use cookies, and much of the work 
# involved in login comes from building this cookie-based authentication machinery
# Instance variable is not required here because we won't render any template.

class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user  # redirect to the user's profile page
    else
      # create an error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    
  end
end
