class ContactMailer < ApplicationMailer

  def message_from_user(contact)
    @user = %Q["#{contact.name}" <#{contact.email}>]
    @message = contact.message

    mail to: "masatoshi.nishiguchi@udc.edu",
         from: contact.email,
         subject: "A message from #{@user}"
  end
end
