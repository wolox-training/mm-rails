class SendNotificationMail
  include Interactor

  def call
    RentMailer.notification_mail(context.rent).deliver_later
  end
end
