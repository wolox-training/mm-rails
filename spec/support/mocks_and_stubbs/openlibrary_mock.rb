module OpenlibraryMock
  BASE_URI = Rails.application.secrets.open_library_uri

  def successfuly_book_get(isbn)
    stub_request(:get, "#{BASE_URI}/books")
      .with(
        query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' }
      )
      .to_return(
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        body: Rails.root.join('spec', 'support', 'fixtures', 'stub',
                              'openlibrary', 'responses', 'success.json')
      )
  end

  def empty_book_get(isbn)
    stub_request(:get, "#{BASE_URI}/books")
      .with(
        query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' }
      )
      .to_return(
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        body: '{}'
      )
  end

  def openlibrary_server_error_book_get(isbn)
    stub_request(:get, "#{BASE_URI}/books")
      .with(
        query: { bibkeys: "ISBN:#{isbn}", format: 'json', jscmd: 'data' }
      )
      .to_return(
        status: 500,
        headers: { 'Content-Type' => 'application/json' }
      )
  end
end
