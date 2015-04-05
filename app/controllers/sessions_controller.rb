=begin
Unlike the Users resource, which uses a database back-end (via the User model)
to persist data, the Sessions resource will use cookies, and much of the work 
involved in login comes from building this cookie-based authentication machinery
=end
class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # log the user in and redirect the user's show page
    else
      # create an error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    
  end
end
