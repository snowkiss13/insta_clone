class ContactMailer < ApplicationMailer
  def contact_mailer(contact)
    @contact = contact

    mail to: @contact.email, subject:"お問合せの確認メール"
  end
end
