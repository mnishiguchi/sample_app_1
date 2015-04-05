require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    # Get to login path and login page should be rendered
    get login_path
    assert_template 'sessions/new'
    # After invalid submission, login page should be re-rendered with a message
    invalid_input = { email: "", password: "" }
    post login_path, session: invalid_input
    assert_template 'sessions/new'
    assert_not flash.empty?
    # The message should disapear upon subsequent request
    get root_path
    assert flash.empty?
  end
end
