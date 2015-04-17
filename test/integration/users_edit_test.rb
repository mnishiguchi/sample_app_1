require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    # Test users are defined in 'fixtures/users.yaml'.
    @user = users(:masa)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",
                                    email: "user@invalid",
                                    password:              "",
                                    password_confirmation: "" }
    assert_template 'users/edit'  # Edit form should be re-rendered.
  end

  test "successful edit with friendly forwarding" do
    # Access the edit page without being logged in.
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]     # Requested URL remembered.
    log_in_as(@user)                            # Login.
    assert_redirected_to edit_user_path(@user)  # Friendly forwarding.
    assert_not session[:forwarding_url]         # Requested URL forgotten.
    # Issue PATCH
    name_edit  = "Foo Bar"
    email_edit = "foobar@example.com"
    patch user_path(@user), user: { name:  name_edit,
                                    email: email_edit,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?              # "Profile updated"
    assert_redirected_to @user
    # Friendly forwarding should not be activated now that user is logged in.
    assert_not session[:forwarding_url]
    # Verify the updates.
    @user.reload
    assert_equal @user.name, name_edit
    assert_equal @user.email, email_edit
  end
end
