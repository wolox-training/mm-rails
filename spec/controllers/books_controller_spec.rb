require 'rails_helper'
require_relative 'shared_context'

describe BooksController do
  it { is_expected.to route(:get, '/books').to(action: :index) }
  it { is_expected.to route(:get, '/books/1').to(action: :show, id: 1) }

  describe 'GET #index' do
    context 'When an user is authenticated' do
      include_context 'Authenticated User'
      context 'When fetching all the books' do
        let!(:books) { create_list(:book, 5) }
        before { get :index }

        it { is_expected.to respond_with :ok }

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

      context 'When params[:limit] == 2' do
        let!(:books) { create_list(:book, 10) }
        before { get :index, params: { limit: 2 } }

        it { is_expected.to respond_with :ok }

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
        end

        it 'responses with a paginated json' do
          expect(response_body).to be_paginated
        end

        it 'responses with a 2 books json' do
          expect(response_body['page'].length).to eq 2
        end
      end

      context 'When params[:genre] == Action' do
        before do
          create_list(:book, 5, genre: 'Action')
          create_list(:book, 5, genre: 'Fantasy')
          get :index, params: { genre: 'Action' }
        end
        subject { response_body }

        it { is_expected.to be_paginated }

        it 'responses with a json with 5 books' do
          expect(response_body['page'].length).to eq 5
        end
        it 'returns only books with genre == Action' do
          expect(response_body['page'].map { |book| book['genre'] }).to satisfy do |genres|
            genres.all? { |genre| genre == 'Action' }
          end
        end
      end

      context 'When params[:author] == Bradford Nolan DDS' do
        before do
          create_list(:book, 2, author: 'Bradford Nolan DDS')
          create_list(:book, 1, author: 'Luis Miguel')
          get :index, params: { author: 'Bradford Nolan DDS' }
        end
        subject { response_body }

        it { is_expected.to be_paginated }
        it 'responses with a json with 2 books' do
          expect(response_body['page'].length).to eq 2
        end
        it 'returns only books with author == Bradford Nolan DDS' do
          expect(response_body['page'].map { |book| book['author'] }).to satisfy do |authors|
            authors.all? { |author| author == 'Bradford Nolan DDS' }
          end
        end
      end

      context 'When params[:title] == La biblia!' do
        before do
          create(:book, title: 'La biblia!')
          create(:book, title: 'Harry Potter')
          get :index, params: { title: 'La biblia!' }
        end
        subject { response_body }

        it { is_expected.to be_paginated }
        it 'responses with a json with 1 book' do
          expect(response_body['page'].length).to eq 1
        end
        it 'returns only a book with title == La biblia!' do
          expect(response_body['page'][0]['title']).to eq 'La biblia!'
        end
      end
    end
    context 'When there is not an authenticated user' do
      context 'When fetching all the books' do
        before { get :index }
        it { is_expected.to respond_with :unauthorized }
      end
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }

    context 'When an user is authenticated' do
      include_context 'Authenticated User'
      before { get :show, params: { id: book.id } }

      it { is_expected.to respond_with :ok }

      it 'responses with the book json' do
        expected = BookSerializer.new(book, root: false).to_json
        expect(response_body.to_json).to eq expected
      end

      it 'responses with a json' do
        expect(response.content_type).to eq 'application/json'
      end
    end

    context 'When there is not an authenticated user' do
      context 'When fetching a book' do
        before { get :index }

        it { is_expected.to respond_with :unauthorized }
      end
    end
  end
end
