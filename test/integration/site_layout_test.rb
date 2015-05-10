require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:masa)
  end

  test "layout links" do
    # Accessing the root page without being logged in.
    get root_path
    assert_template 'static_pages/home'

    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', lab_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contacts_path
    assert_select 'a[href=?]', signup_path
    assert_select 'a[href=?]', login_path
    # Logged in user accessing the root page.
    log_in_as @user
    get root_path
    assert_select 'a[href=?]', users_path             # Users
    assert_select 'a[href=?]', user_path(@user)       # Profile
    assert_select 'a[href=?]', edit_user_path(@user)  # Settings
    assert_select 'a[href=?]', logout_path            # Log out
    assert_select 'a[href=?]', login_path, count: 0
    # Accessing the sign up page.
    get signup_path
    assert_select 'title', full_title("Sign up")
  end
end
