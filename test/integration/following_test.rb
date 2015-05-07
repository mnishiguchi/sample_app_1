require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:masa)
    log_in_as(@user)
  end

  test "following page" do
    # Masa is currently following a few users.
    # He trys to list his following.
    get following_user_path(@user)
    assert_not @user.following.empty?
    # Correct following count should be displayed.
    assert_match @user.following.count.to_s, response.body
    # Each item should have a link to his/her profile page.
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "followers page" do
    # Masa is currently followed by a few users.
    # He trys to list who is following him.
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    # Correct followers count should be displayed.
    assert_match @user.followers.count.to_s, response.body
    # Each item should have a link to his/her profile page.
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end
