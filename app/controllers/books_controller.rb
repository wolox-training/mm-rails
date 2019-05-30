class BooksController < ApplicationController
  before_action :authenticate_user!, except: :open_library_information

  def index
    render_paginated Book::Reducer.apply(params), each_serializer: BookPreviewSerializer
  end

  def show
    render json: Book.find(params[:id])
  end

  def open_library_information
    return render_errors('ISBN should be numeric', :bad_request) unless valid_isbn?

    render json: OpenlibraryService.new.search_by_isbn(isbn), status: :ok
  rescue OpenlibraryService::BookNotFoundError => e
    render_errors(e.message, :not_found)
  end

  private

  def isbn
    @isbn ||= params[:isbn]
  end

  def valid_isbn?
    isbn&.is_number?
  end
end
