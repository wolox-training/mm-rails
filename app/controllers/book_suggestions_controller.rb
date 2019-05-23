class BookSuggestionsController < ApplicationController
  def create
    book_suggestion = BookSuggestion.create!(book_suggestion_params)

    render json: book_suggestion, status: :created
  end

  def book_suggestion_params
    params.require(:book_suggestion)
          .permit(:synopsis, :price, :title, :author, :link, :publisher, :year)
  end
end
