class RentsController < ApplicationController
  before_action :authenticate_user!, :validate_user

  def index
    render_paginated current_user.rents
  end

  def create
    rent = Rent.new(rent_params)
    authorize rent
    result = RentCreation.call(rent: rent)

    render_result(result, success_status: :created, error_status: :unprocessable_entity)
  end

  private

  def rent_params
    params.require(:rent)
          .permit(:book_id, :starting_date, :ending_date)
          .merge(user_id: current_user.id)
  end

  def validate_user
    raise Pundit::NotAuthorizedError, 'Not allowed to use this resource' unless
      current_user.id.to_s == params[:user_id]
  end
end
