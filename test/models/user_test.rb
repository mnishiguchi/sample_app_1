# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    # create a user in memory.
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # User Name

  test "name should be present" do
    blank_name = "     "
    @user.name = blank_name
    assert_not @user.valid?
  end

  test "name should not be too long" do
    invalid_name = "a" * 51
    @user.name = invalid_name
    assert_not @user.valid?
  end

  # User Email

  test "email should be present" do
    blank_email = "    "
    @user.email = blank_email
    assert_not @user.valid?
  end

  test "email should not be too long" do
    invalid_email = "a" * 244 + "@example.com"  # max: 255
    @user.email = invalid_email
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    # Email format validation is tricky and error-prone
    # make sure valid addressed are accepted while invalid ones are rejected
    valid_addresses = %w(user@example.com
                        USER@foo.COM
                        A_US-ER@foo.bar.org
                        first.last@foo.jp
                        alice+bob@baz.cn)
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      # display specific address that failed in case of error
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w(user@example,com
                          user_at_foo.org
                          user.name@example.
                          foo@bar_baz.com
                          foo@bar+baz.com
                          foo@bar..com)
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

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save  # save @user to database
    # reload @user from database and verify email was converted to lowercase
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  # Password

  test "password should have a minimum length" do
    invalid_password = "a" * 5
    @user.password = @user.password_confirmation = invalid_password
    assert_not @user.valid?
  end

  # Digest

  test "authenticate_with_token should return nil for a user with nil digest" do
    assert_not @user.authenticate_with_token(:remember, "")
  end

  # Microposts

  test "associated microposts should be destroyed" do
    # Save user to database.
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")  # create! raises error if any
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  # Following

  test "should follow and unfollow a user" do
    # Before following
    masa = users(:masa)
    archer  = users(:archer)
    assert_not masa.following?(archer)
    # After following
    masa.follow(archer)
    assert masa.following?(archer)
    assert archer.followers.include?(masa)
    # Unfollowing
    masa.unfollow(archer)
    assert_not masa.following?(archer)
    assert_not archer.followers.include?(masa)
  end

  test "feed should have the right posts" do
    masa   = users(:masa)
    archer = users(:archer)  # Masa doesn't follow Archer.
    lana   = users(:lana)    # Masa follows Lana.
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert masa.feed.include?(post_following)
    end
    # Posts from self
    masa.microposts.each do |post_self|
      assert masa.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not masa.feed.include?(post_unfollowed)
    end
  end
end
