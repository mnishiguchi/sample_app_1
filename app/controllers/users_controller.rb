class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Masa's Sample App 1!"
      redirect_to @user  # show a user profile page
    else
      render 'new'       # re-render the signup form
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'      # re-render the edit form
    end

  end

  #----------------------------------------------------------------------------
  private

    def user_params
      # Must submit user and only specified attributes are permitted.
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before-filters

    # Confirm if a user is logged in.
    def logged_in_user
      unless user_logged_in?
        store_location  # For friendly forwarding.
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirm if a user is the current user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
