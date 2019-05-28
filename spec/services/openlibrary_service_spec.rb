require 'rails_helper'

describe OpenlibraryService do
  include OpenlibraryMock
  let(:service) { OpenlibraryService.new }
  let(:uri) { 'https://openlibrary.org/api/books' }

  context 'when searching a book by isbn' do
    before { successfuly_book_get }

    let(:isbn) { '0385472579' }
    subject! { service.search_by_isbn(isbn) }

    it 'makes an external web request' do
      expect(WebMock).to have_requested(:get, "#{uri}?bibkeys=ISBN:#{isbn}&format=json&jscmd=data")
    end

    it 'responses with a Hash' do
      is_expected.to be_a Hash
    end

    it 'responses with a Hash with expected keys' do
      expected_keys = %i[isbn title subtitle number_of_pages authors]
      is_expected.to include(*expected_keys)
    end
  end
end
