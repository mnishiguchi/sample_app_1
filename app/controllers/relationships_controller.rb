class RelationshipsController < ApplicationController
  before_action :logged_in_user

  # The current user will follow somebody.
  # follower: current_user
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # Only one of the lines gets executed.
    # The respond_to is like an if-then-else statement than a series of sequential lines.
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  # The current user will unfollow somebody.
  # Looks for the followed through passive relationship.
  # follower: current_user
  def destroy
    followed_id = params[:id]
    passive_rel = Relationship.find(followed_id)
    @user = passive_rel.followed
    current_user.unfollow(@user)
    # Only one of the lines gets executed.
    # The respond_to is like an if-then-else statement than a series of sequential lines.
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
