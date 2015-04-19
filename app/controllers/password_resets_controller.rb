class PasswordResetsController < ApplicationController

  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  # Renders the forgot password form.
  def new
  end

  # Searches for a user by submitted email.
  # Sends the user an email with a password reset url if s/he is found.
  def create
    # Ensure all lower case email before performing query.
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  # Accessed by a reset password url that has been sent to a user.
  # Authorizes access by before filters.
  # Renders the password reset form.
  def edit
  end

  # Authorizes access by before filters.
  # Performs password reset and login if the user is valid.
  def update
    # Rejects blank password.
    if password_blank?
      flash.now[:danger] = "Password can't be blank"
      render 'edit'
    # Successful password reset.
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset"
      redirect_to @user
    # Unsuccessful.
    else
      render 'edit'
    end
  end

  #----------------------------------------------------------------------------
  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Returns true if password is blank.
    def password_blank?
      params[:user][:password].blank?
    end

    # Before filters

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    # 1. Rejects nil user.
    # 2. Rejects non-activated user.
    # 3. Rejects access with invalid reset-token.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticate_with_token(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    # Requires a user with expired token to get a new one.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
