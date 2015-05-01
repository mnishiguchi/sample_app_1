class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # Providing feed items to be displayed on the home page.
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'

      # Note: To avoid error caused by paginating from MicropostsController,
      # the following route is set: get 'microposts' => 'static_pages#home'
    end
  end

  def destroy
  end

  #----------------------------------------------------------------------------
  private

    def micropost_params
      params.require(:micropost).permit(:content)

    end

    # NOTE: The logged_in_user filter is defined in ApplicationController.
end
