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

  test "email validation should accept valid addresses" do
    # Email format validation is tricky and error-prone
    # make sure valid addressed are accepted while invalid ones are rejected
    valid_addresses = %w(user@example.com USER@foo.COM
                        A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      # display specific address that failed in case of error
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w(user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com)
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      # display specific address that failed in case of error
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    @user.save                        # @user is saved to database
    duplicate_user = @user.dup        # try to sign up with the same address
    duplicate_user.email = @user.email.upcase  # check for case insensitivity
    assert_not duplicate_user.valid?  # should be rejected
  end
end
