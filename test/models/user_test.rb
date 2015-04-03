require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    # create a user in memory.
    @user = User.new(name: "Example User", email: "user@example.com")
  end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    blank_name = "     "
    @user.name = blank_name
    assert_not @user.valid?
  end

  test "email should be present" do
    blank_email = "    "
    @user.email = blank_email
    assert_not @user.valid?
  end

  test "name should not be too long" do
    invalid_name = "a" * 51
    @user.name = invalid_name
    assert_not @user.valid?
  end

  test "email should not be too long" do
    invalid_email = "a" * 244 + "@example.com"
    @user.email = invalid_email
    assert_not @user.valid?
  end
end
