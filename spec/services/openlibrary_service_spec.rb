require 'rails_helper'

describe OpenlibraryService do
  include OpenlibraryMock
  let(:service) { OpenlibraryService.new }
  let(:uri) { 'https://openlibrary.org/api/books' }

  describe '#search_by_isbn' do
    subject { service.search_by_isbn(isbn) }

    context 'when getting a successfuly response' do
      before do
        successfuly_book_get
        subject
      end

      let(:isbn) { '0385472579' }

      it 'makes an external web request' do
        expect(WebMock)
          .to have_requested(:get, "#{uri}?bibkeys=ISBN:#{isbn}&format=json&jscmd=data")
          .once
      end

      it 'responses with a Hash' do
        is_expected.to be_a Hash
      end

      it 'responses with a Hash with expected keys' do
        expected_keys = %i[isbn title subtitle number_of_pages authors]
        is_expected.to include(*expected_keys)
      end
    end

    context 'when getting an empty response' do
      before { empty_book_get }

      let(:isbn) { '12345' }

      it 'makes an external web request' do
        subject
      rescue OpenlibraryService::BookNotFoundError
        expect(WebMock)
          .to have_requested(:get, "#{uri}?bibkeys=ISBN:#{isbn}&format=json&jscmd=data")
          .once
      end

      it 'raises BookNotFoundError' do
        expect { subject }.to raise_error OpenlibraryService::BookNotFoundError
      end
    end

    context 'when getting an unsuccessfully response' do
      before { internal_server_error_book_get }

      let(:isbn) { '9780201485370' }

      it 'makes an external web request' do
        subject
      rescue OpenlibraryService::BookNotFoundError
        expect(WebMock)
          .to have_requested(:get, "#{uri}?bibkeys=ISBN:#{isbn}&format=json&jscmd=data")
          .once
      end

      it 'raises BookNotFoundError' do
        expect { subject }.to raise_error OpenlibraryService::BookNotFoundError
      end
    end
  end
end
