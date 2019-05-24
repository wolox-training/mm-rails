class RentMailer < ApplicationMailer
  def notification_mail(rent)
    @rent = rent
    @user = @rent.user
    mail(to: @user.email, subject: 'Your rent has_been registered')
  end
end
