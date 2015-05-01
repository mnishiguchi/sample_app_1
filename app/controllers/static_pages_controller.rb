class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if user_logged_in?
  end

  def lab
  end

  def about
  end

  def contact
  end
end
