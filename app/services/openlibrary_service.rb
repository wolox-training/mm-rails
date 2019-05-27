class OpenlibraryService
  include HTTParty
  base_uri 'https://openlibrary.org/api'

  default_params format: :json, jscmd: 'data'

  class BookNotFoundError < StandardError
  end

  def search_by_isbn(isbn)
    @isbn = isbn
    isbn_string = "ISBN:#{@isbn}"
    options = { query: { bibkeys: isbn_string } }
    response = self.class.get('/books', options)

    return parse_response_book(response[isbn_string]) if response.success?

    raise BookNotFoundError, response.response
  end

  private

  def parse_response_book(book)
    {
      isbn: @isbn,
      title: book['title'],
      subtitle: book['subtitle'],
      number_of_pages: book['number_of_pages'],
      authors: book['authors'].map { |author| author['name'] }
    }
  rescue StandardError
    raise BookNotFoundError, 'Invalid response book'
  end
end
