class RentMailer < ApplicationMailer
  def notification_mail(rent)
    @rent = rent
    @user = @rent.user
    mail(to: @user.email, subject: t('rent_notification_mail.subject'))
  end
end
