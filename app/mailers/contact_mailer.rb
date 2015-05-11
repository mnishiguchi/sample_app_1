class ContactMailer < ApplicationMailer

  def message_from_user(contact)
    @message = contact.message
    user_with_email = %Q("#{contact.name}" <#{contact.email}>)

    mail to: "masatoshi.nishiguchi@udc.edu",
         from: contact.email,
         subject: "A message from #{user_with_email}"
  end
end
