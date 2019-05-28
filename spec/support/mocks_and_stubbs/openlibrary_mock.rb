module OpenlibraryMock
  BASE_URI = 'https://openlibrary.org/api'.freeze

  def successfuly_book_get
    stub_request(:get, "#{BASE_URI}/books")
      .with(
        query: { bibkeys: 'ISBN:0385472579', format: 'json', jscmd: 'data' }
      )
      .to_return(
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        body: File.read('./spec/support/fixtures/openlibrary/response_success.json')
      )
  end
end
