class OpenlibraryService
  include HTTParty
  base_uri 'https://openlibrary.org/api'

  default_params format: :json, jscmd: 'data'

  def search_by_isbn(isbn)
    isbn_string = "ISBN:#{isbn}"
    options = { query: { bibkeys: isbn_string } }
    self.class.get('/books', options)
  end
end
