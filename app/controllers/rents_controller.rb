class RentsController < ApplicationController
  include Wor::Paginate
  before_action :authenticate_user!

  def index
    render_paginated user.rents
  end

  def create
    rent = Rent.new user_id: rent_params[:user_id],
                    book_id: rent_params[:book_id],
                    starting_date: rent_params[:from],
                    ending_date: rent_params[:to]

    if rent.save
      render json: rent, status: :created
    else
      render json: rent.errors, status: :unprocessable_entity
    end
  end

  def rent_params
    params.require(:rent)
          .permit(:user_id, :book_id, :from, :to)
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
