class RentCreation
  include Interactor::Organizer

  organize CreateRent, SendNotificationMail
end
