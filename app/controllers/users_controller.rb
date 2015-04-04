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
      # handle a successful save
    else
      render 'new'  # re-render 'new' template (signup form)
    end
  end

  private

    def user_params
      # Must submit user and only specified attributes are permitted
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end