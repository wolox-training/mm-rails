class RentsController < ApplicationController
  before_action :authenticate_user!

  def index
    render_paginated current_user.rents
  end

  def create
    rent = Rent.new(rent_params)

    if rent.save
      render json: rent, status: :created
    else
      render json: rent.errors, status: :unprocessable_entity
    end
  end

  private

  def rent_params
    params.require(:rent)
          .permit(:book_id, :starting_date, :ending_date)
          .merge(user_id: current_user.id)
  end
end
