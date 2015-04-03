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
end
