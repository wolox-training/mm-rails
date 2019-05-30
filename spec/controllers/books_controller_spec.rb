require 'rails_helper'

describe BooksController do
  describe 'GET #index' do
    context 'When an user is authenticated' do
      include_context 'With an authenticated User'
      context 'When fetching all the books' do
        let!(:books) { create_list(:book, 5) }
        subject(:http_response) { get :index }
        before { http_response }

        it { is_expected.to have_http_status :ok }

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
        end

        it 'responses with a paginated json' do
          expect(response_body).to be_paginated
        end

        it 'responses with the books json' do
          expected = ActiveModel::Serializer::CollectionSerializer.new(
            books, serializer: BookPreviewSerializer
          ).to_json
          expect(response_body['page']).to eq JSON.parse(expected)
        end
      end

      context 'When fetching with limit' do
        let(:limit) { 2 }
        let!(:books) { create_list(:book, 10) }
        subject(:http_response) { get :index, params: { limit: limit } }
        before { http_response }

        it { is_expected.to have_http_status :ok }

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
        end

        it 'responses with a paginated json' do
          expect(response_body).to be_paginated
        end

        it 'responses with a 2 books json' do
          expect(response_body['count']).to eq 2
        end
      end

      context 'when searching by genre_name' do
        let(:genre_name) { 'Action' }
        subject(:http_response) { get :index, params: { genre: genre_name } }

        before do
          create_list(:book, 5, genre: genre_name)
          create_list(:book, 5, genre: 'Fantasy')
          http_response
        end

        it { expect(response_body).to be_paginated }

        it 'responses with a json with 5 books' do
          expect(response_body['count']).to eq 5
        end
        it 'returns only books with genre == Action' do
          expect(response_body['page'].pluck('genre')).to be_all do |genre|
            genre == genre_name
          end
        end
      end

      context 'when searching by author name' do
        let(:author_name) { 'Bradford Nolan DDS' }
        subject(:http_response) { get :index, params: { author: author_name } }

        before do
          create_list(:book, 2, author: author_name)
          create_list(:book, 1, author: 'Luis Miguel')
          http_response
        end

        it { expect(response_body).to be_paginated }
        it 'responses with a json with 2 books' do
          expect(response_body['count']).to eq 2
        end
        it 'returns books filtered by author name' do
          expect(response_body['page'].pluck('author')).to be_all do |author|
            author == author_name
          end
        end
      end

      context 'when searching by title' do
        let(:title) { 'La biblia!' }
        subject(:http_response) { get :index, params: { title: title } }
        before do
          create(:book, title: title)
          create(:book, title: 'Harry Potter')
          http_response
        end

        it { expect(response_body).to be_paginated }
        it 'responses with a json with 1 book' do
          expect(response_body['count']).to eq 1
        end
        it 'returns books with the searched title' do
          expect(response_body['page'][0]['title']).to eq title
        end
      end
    end
    context 'whithout an authenticated user' do
      context 'When fetching all the books' do
        subject(:http_response) { get :index }
        before { http_response }
        it { is_expected.to have_http_status :unauthorized }
      end
    end
  end

  describe 'GET #show' do
    context 'When an user is authenticated' do
      include_context 'With an authenticated User'
      context 'When searching for a book' do
        let(:book) { create(:book) }
        subject(:http_response) { get :show, params: { id: book.id } }
        before { http_response }

        it { is_expected.to have_http_status :ok }

        it 'responses with the book json' do
          expected = BookSerializer.new(book, root: false).to_json
          expect(response_body.to_json).to eq expected
        end

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
        end
      end

      context 'when searching for an unexisting book' do
        let(:searched_id) { -1 }
        subject(:http_response) { get :show, params: { id: searched_id } }
        before { http_response }

        it { is_expected.to have_http_status :not_found }
      end
    end

    context 'without an authenticated user' do
      context 'When fetching a book' do
        let(:book) { create(:book) }
        subject(:http_response) { get :show, params: { id: book.id } }
        before { http_response }

        it { is_expected.to have_http_status :unauthorized }
      end
    end
  end

  describe 'GET #open_library_information' do
    subject(:http_response) { get :open_library_information, params: { isbn: isbn } }
    context 'when searching for a book by isbn' do
      context 'when response from openlibrary is ok' do
        let(:isbn) { Faker::Number.number(10) }
        let(:book_information) { attributes_for(:book_information, isbn: isbn) }

        before do
          allow_any_instance_of(OpenlibraryService)
            .to receive(:search_by_isbn)
            .and_return(book_information)
          http_response
        end

        it { is_expected.to have_http_status :ok }

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
        end

        it 'responses with the book information json' do
          expect(response_body.to_json).to eq book_information.to_json
        end
      end
    end

    context 'when searching for a book with an invalid isbn' do
      let(:isbn) { Faker::University.name }
      before do
        http_response
      end

      it { is_expected.to have_http_status :bad_request }

      it 'responses with isbn error message' do
        error_msg = 'ISBN should be numeric'
        expect(response_body['errors']).to eq error_msg
      end
    end
  end
end
