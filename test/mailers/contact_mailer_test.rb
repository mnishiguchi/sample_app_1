require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  def setup
    @contact = Contact.new(name:    "Example User",
                           email:   "user@example.com",
                           message: "Lorem ipsum dolor sit amet.")
  end

  test "message_from_user" do
    mail = ContactMailer.message_from_user(@contact)
    # Subject, from, to
    assert_equal 'A message from "Example User" <user@example.com>', mail.subject
    assert_equal ["masatoshi.nishiguchi@udc.edu"], mail.to
    assert_equal [@contact.email], mail.from
    # Contents
    assert_match @contact.message, mail.body.encoded
  end

end
