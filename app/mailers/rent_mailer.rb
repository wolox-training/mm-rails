class RentMailer < ApplicationMailer
  def notification_mail
    @rent = params[:rent]
    @user = @rent.user
    mail(to: @user.email, subject: 'Your rent has been registered')
  end
end
