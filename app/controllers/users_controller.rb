class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
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
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'      # re-render the edit form
    end

  end

  private

    def user_params
      # Must submit user and only specified attributes are permitted
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
