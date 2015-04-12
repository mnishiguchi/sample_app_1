require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    # Test users are defined in 'fixtures/users.yaml'.
    @user = users(:masa)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    patch user_path(@user), user: { name:  "",
                                     email: "user@invalid",
                                     password:              "",
                                     password_confirmation: "" }
    # Edit form should be re-rendered.
    assert_template 'users/edit'
  end
end
