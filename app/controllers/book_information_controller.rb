class BookInformationController < ApplicationController
  def show
    isbn = params[:isbn]
    return head :bad_request unless isbn

    render json: OpenlibraryService.new.search_by_isbn(isbn), status: :ok
  rescue OpenlibraryService::BookNotFoundError
    raise ActiveRecord::RecordNotFound
  end
end
