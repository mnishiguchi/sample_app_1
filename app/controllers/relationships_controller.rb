class RelationshipsController < ApplicationController
  before_action :logged_in_user

  # The current user will follow somebody.
  # follower: current_user
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  # The current user will unfollow somebody.
  # Looks for the followed through passive relationship.
  # follower: current_user
  def destroy
    followed_id = params[:id]
    passive_rel = Relationship.find(followed_id)
    user = passive_rel.followed
    current_user.unfollow(user)
    redirect_to user
  end
end
