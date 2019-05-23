class RentPolicy < ApplicationPolicy
  alias rent record

  def create?
    user.id == rent.user_id
  end
end
