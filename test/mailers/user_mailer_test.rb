require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    @user = users(:masa)                     # A test @user from fixture.
  end

  test "account_activation" do
    @user.activation_token = User.new_token  # Give the user a virtual attribute.
    mail = UserMailer.account_activation(@user)
    # Subject, from, to
    assert_equal "Account activation",    mail.subject
    assert_equal [@user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
    # Contents
    assert_match @user.name,               mail.body.encoded
    assert_match @user.activation_token,   mail.body.encoded
    assert_match CGI::escape(@user.email), mail.body.encoded  # @ => %40
  end

  test "password_reset" do
    @user.reset_token = User.new_token  # Give the user a virtual attribute.
    mail = UserMailer.password_reset(@user)
    # Subject, from, to
    assert_equal "Password reset", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    # Contents
    assert_match @user.reset_token,        mail.body.encoded
    assert_match CGI::escape(@user.email), mail.body.encoded  # @ => %40
  end

end
