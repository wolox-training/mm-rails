class BookSuggestionsController < ApplicationController
  def create
    book_suggestion = BookSuggestion.new(book_suggestion_params)
    return render json: book_suggestion, status: :created if book_suggestion.save

    render json: book_suggestion.errors, status: :unprocessable_entity
  end

  private

  def book_suggestion_params
    params.require(:book_suggestion)
          .permit(:synopsis, :price, :title, :author, :link, :publisher, :year)
  end
end
