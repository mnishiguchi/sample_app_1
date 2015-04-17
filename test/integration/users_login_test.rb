require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    # test users are defined in fixtures/users.yaml.
    @user = users(:masa)
  end

  test "login with invalid information" do
    # Get to login path and login page should be rendered.
    get login_path
    assert_template 'sessions/new'
    # After invalid submission, login page should be re-rendered with a message.
    invalid_input = { email: "", password: "" }
    post login_path, session: invalid_input
    assert_template 'sessions/new'
    assert_not flash.empty?
    # The message should disapear upon subsequent request.
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    # Login.
    get login_path
    valid_input = { email: @user.email, password: 'password' }
    post login_path, session: valid_input
    assert is_logged_in?
    assert_redirected_to @user
    # After the redirect, appropreate links should be displayed.
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 # Login link should disappear.
    assert_select "a[href=?]", logout_path          # Logout link should appear.
    assert_select "a[href=?]", user_path(@user)     # Profile link should appear.
    assert_select "a[href=?]", users_path           # All users link should appear.
    # Logout.
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate clicking logout again in a different window.
    delete logout_path
    # After the redirect, appropreate links should be displayed.
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", users_path ,      count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    # access @user in SessionsController to get remember_token attribute
    assert_equal assigns(:user).remember_token, cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
