class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # GET /users/me
  def me
    render json: current_user
  end

  # POST /users
  def create
    create_params = params.require(:user)
                          .permit(:email, :password, :password_confirmation,
                                  :first_name, :last_name, :locale)
    @user = User.new(create_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.fetch(:user, {})
  end
end
