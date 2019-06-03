class SendNotificationMail
  include Interactor
  delegate :rent, to: :context

  def call
    RentMailer.notification_mail(rent).deliver_later
  end
end
