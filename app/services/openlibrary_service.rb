class OpenlibraryService
  include HTTParty
  base_uri Rails.application.secrets.open_library_uri

  default_params format: :json, jscmd: 'data'

  def search_by_isbn(isbn)
    @isbn = isbn
    parse_book(open_library_response)
  end

  private

  def open_library_response
    @isbn_string = "ISBN:#{@isbn}"
    options = { query: { bibkeys: @isbn_string } }
    response = self.class.get('/books', options)
    raise CustomErrors::BookNotFoundError, 'Openlibrary API request failed' unless
      response.success?

    response
  end

  def parse_book(response)
    @book = response[@isbn_string]
    raise CustomErrors::BookNotFoundError, 'Invalid response book' unless valid_book_attributes?

    parsed_book_data
  end

  def valid_book_attributes?
    @book && @book['authors'].is_a?(Array) &&
      @book.include_all?('title', 'subtitle', 'number_of_pages', 'authors')
  end

  def parsed_book_data
    {
      isbn: @isbn,
      title: @book['title'],
      subtitle: @book['subtitle'],
      number_of_pages: @book['number_of_pages'],
      authors: @book['authors'].map { |author| author['name'] }
    }
  end
end
