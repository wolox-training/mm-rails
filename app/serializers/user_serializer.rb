class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :rents_counter

  def rents_counter
    object.rents.count
  end
end
