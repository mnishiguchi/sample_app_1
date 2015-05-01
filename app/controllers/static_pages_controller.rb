class StaticPagesController < ApplicationController

  def home
    if user_logged_in?  # To avoid errors due to nil current user.
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def lab
  end

  def about
  end

  def contact
  end
end
