require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:masa)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    # Title
    assert_select 'title', full_title(@user.name)
    # Gravatar
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    # Microposts with pagination
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
    # Following/follower stats
    assert_select 'a[href=?]', following_user_path(@user)
    assert_select 'a[href=?]', followers_user_path(@user)
    assert_select '#following', text: @user.following.count.to_s
    assert_select '#followers', text: @user.followers.count.to_s
  end
end
