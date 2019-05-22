class RentMailer < ApplicationMailer
  def notification_mail(rent)
    @rent = rent
    @user = @rent.user
    mail(to: @user.email, subject: 'Your rent has been registered')
  end
end
