class BooksController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate

  before_action :authenticate_user!

  def index
    render_paginated Book
  end

  def show
    if book
      render json: book
    else
      render json: {}, status: :not_found
    end
  end

  def book
    @book ||= Book.find params[:id]
  end
end
