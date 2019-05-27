class UsersController < ApplicationController
  before_action :authenticate_user!, only: :me

  # GET /users
  def index
    render_paginated User
  end

  # GET /users/1
  def show
    render json: user
  end

  # GET /users/me
  def me
    render json: current_user
  end

  private

  def user
    @user ||= User.find(user_params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:id)
  end
end
