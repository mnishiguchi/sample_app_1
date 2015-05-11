class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  # Shows all the activated users with pagination.
  # Warning: users must be activated.
  def index
    @search = User.where(activated: true).search(params[:q])
    @users = @search.result.paginate(page: params[:page])
    # @users = User.all
    # @users = User.paginate(page: params[:page])
    # @users = User.where(activated: true).paginate(page: params[:page])
  end

  # Shows a profile page only if the user is activated.
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'       # Re-render the signup form.
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'      # Re-render the edit form.
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  # Lists whom the user is following.
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  # Lists all the followers.
  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #----------------------------------------------------------------------------
  private

    def user_params
      # Permits only listed attributes through the web.
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before-filters

    # NOTE: The logged_in_user filter is defined in ApplicationController.

    # Confirms if a user is the current user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

     # Confirms if a user is an admin.
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
