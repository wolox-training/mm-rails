class RentsController < ApplicationController
  include Wor::Paginate
  before_action :authenticate_user!

  def index
    render_paginated current_user.rents
  end

  def create
    rent = Rent.create user_id: rent_params[:user_id],
                       book_id: rent_params[:book_id],
                       starting_date: rent_params[:from],
                       ending_date: rent_params[:to]

    render json: rent, status: :created
  end

  def rent_params
    params.require(:rent)
          .permit(:user_id, :book_id, :from, :to)
  end
end
