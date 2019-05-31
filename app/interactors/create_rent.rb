class CreateRent
  include Interactor

  def call
    rent = context.rent
    if rent.save
      context.rent = rent
    else
      context.fail!
    end
  end
end
