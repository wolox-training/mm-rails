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

  def empty_book_get
    stub_request(:get, "#{BASE_URI}/books")
      .with(
        query: { bibkeys: 'ISBN:12345', format: 'json', jscmd: 'data' }
      )
      .to_return(
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        body: '{}'
      )
  end

  def internal_server_error_book_get
    stub_request(:get, "#{BASE_URI}/books")
      .with(
        query: { bibkeys: 'ISBN:9780201485370', format: 'json', jscmd: 'data' }
      )
      .to_return(
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        body: '{}'
      )
  end
end
