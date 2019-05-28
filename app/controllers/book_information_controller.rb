class BookInformationController < ApplicationController
  def show
    return render_errors({ isbn: 'ISBN should be numeric' }, :bad_request) unless valid_isbn?

    render json: OpenlibraryService.new.search_by_isbn(isbn), status: :ok
  rescue OpenlibraryService::BookNotFoundError => e
    render_errors(e.message, :not_found)
  end

  private

  def isbn
    @isbn ||= params[:isbn]
  end

  def valid_isbn?
    isbn&.contains_only_digits?
  end
end
