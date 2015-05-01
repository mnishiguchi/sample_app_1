class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # TODO: Show status feed without error due to nil @feed_items.
      # TODO: Show status feed without error on pagination.
      @feed_items = []
      render 'static_pages/home'
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
