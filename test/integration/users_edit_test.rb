require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    # Test users are defined in 'fixtures/users.yaml'.
    @user = users(:masa)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",
                                    email: "user@invalid",
                                    password:              "",
                                    password_confirmation: "" }
    assert_template 'users/edit'  # Edit form should be re-rendered.
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name_edit  = "Foo Bar"
    email_edit = "foobar@example.com"
    patch user_path(@user), user: { name:  name_edit,
                                    email: email_edit,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    # Reload attributes from database and verify the updates
    @user.reload
    assert_equal @user.name, name_edit
    assert_equal @user.email, email_edit
  end
end
