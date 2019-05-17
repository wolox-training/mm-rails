class BooksController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate

  before_action :authenticate_user!

  def index
    render_paginated Book::Reducer.apply(params), each_serializer: BookPreviewSerializer
  end

  def show
    render json: Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
