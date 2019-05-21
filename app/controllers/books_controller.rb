class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    render_paginated Book::Reducer.apply(params), each_serializer: BookPreviewSerializer
  end

  def show
    render json: Book.find(params[:id])
  end
end
