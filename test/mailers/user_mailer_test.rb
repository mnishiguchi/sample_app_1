require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:masa)                     # A test user from fixture.
    user.activation_token = User.new_token  # Give it a virtual attribute.
    mail = UserMailer.account_activation(user)
    # Header
    assert_equal "Account activation",    mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from  #
    # Contents
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded  # @ => %40
  end

  # test "password_reset" do
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal ["to@example.org"], mail.to
  #   assert_equal ["from@example.com"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
