require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:masa)
    remember(@user)
  end

  # current_user method

  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    # authentication with remember token should fail
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
