require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    # To prevent code here from breaking in case any other tests deliver email.
    ActionMailer::Base.deliveries.clear
  end


  test "invalid signup information" do
    get signup_path
    invalid_input = { name:  "",
                      email: "user@invalid",
                      password:              "foo",
                      password_confirmation: "bar" }
    # Invalid user shouldn't be created.
    assert_no_difference 'User.count' do
      post users_path, user: invalid_input
    end
    # Signup form should be re-rendered.
    assert_template 'users/new'
    # Error info should be correctly displayed.
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information with account activation" do
    get signup_path
    valid_input = { name:  "Example User",
                    email: "user@example.com",
                    password:              "password",
                    password_confirmation: "password" }
    # Valid user should be created.
    assert_difference 'User.count', 1 do
      post users_path, user: valid_input
    end
    # Activation email should be sent.
    assert_equal 1, ActionMailer::Base.deliveries.size
    # User shouldn't be activated upon signup
    user = assigns(:user)  # Access corresponding user in UsersController.
    assert_not user.activated?
    # Try to log in without activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?  # Should be activated in database.
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
