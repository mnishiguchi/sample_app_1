require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    invalid_input = { name:  "",
                      email: "user@invalid",
                      password:              "foo",
                      password_confirmation: "bar" }
    # user count should be the same before and after submission
    assert_no_difference 'User.count' do
      post users_path, user: invalid_input
    end
    # signup form should be re-rendered
    assert_template 'users/new'
    # error info should be correctly displayed
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    valid_input = { name:  "Example User",
                    email: "user@example.com",
                    password:              "password",
                    password_confirmation: "password" }
    # post signup form, then redirect to user profile page
    # user count should increment by one after submission
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: valid_input
    end
    
    assert_template 'users/show'  # user profile should be rendered
    assert_not_nil flash          # there should be flash message
  end
end