class CheckExpiredRentsWorker
  include Sidekiq::Worker

  def perform(*_args)
    Rent.expiring_today.each do |rent|
      RentMailer.expiration_mail(rent).deliver_later
    end
  end
end
