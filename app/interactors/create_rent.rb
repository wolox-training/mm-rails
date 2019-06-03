class CreateRent
  include Interactor
  delegate :rent, to: :context

  def call
    if rent.save
      context.rent = rent
      context.output = rent
    else
      context.fail!(errors: rent.errors.full_messages)
    end
  end
end
