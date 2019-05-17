require 'rails_helper'

describe BooksController do
  describe 'GET #index' do
    context 'When an user is authenticated' do
      include_context 'With an authenticated User'
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

      context 'When fetching with limit' do
        let(:limit) { 2 }
        let!(:books) { create_list(:book, 10) }
        before { get :index, params: { limit: limit } }

        it { is_expected.to respond_with :ok }

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
        before do
          create_list(:book, 5, genre: genre_name)
          create_list(:book, 5, genre: 'Fantasy')
          get :index, params: { genre: genre_name }
        end
        subject { response_body }

        it { is_expected.to be_paginated }

        it 'responses with a json with 5 books' do
          expect(response_body['count']).to eq 5
        end
        it 'returns only books with genre == Action' do
          expect(response_body['page'].map { |book| book['genre'] }).to satisfy do |genres|
            genres.all? { |genre| genre == genre_name }
          end
        end
      end

      context 'when searching by author name' do
        let(:author_name) { 'Bradford Nolan DDS' }
        before do
          create_list(:book, 2, author: author_name)
          create_list(:book, 1, author: 'Luis Miguel')
          get :index, params: { author: author_name }
        end
        subject { response_body }

        it { is_expected.to be_paginated }
        it 'responses with a json with 2 books' do
          expect(response_body['count']).to eq 2
        end
        it 'returns books filtered by author name' do
          expect(response_body['page'].map { |book| book['author'] }).to satisfy do |authors|
            authors.all? { |author| author == author_name }
          end
        end
      end

      context 'when searching by title' do
        let(:title) { 'La biblia!' }
        before do
          create(:book, title: title)
          create(:book, title: 'Harry Potter')
          get :index, params: { title: title }
        end
        subject { response_body }

        it { is_expected.to be_paginated }
        it 'responses with a json with 1 book' do
          expect(response_body['count']).to eq 1
        end
        it 'returns only a book with title == La biblia!' do
          expect(response_body['page'][0]['title']).to eq title
        end
      end
    end
    context 'whithout an authenticated user' do
      context 'When fetching all the books' do
        before { get :index }
        it { is_expected.to respond_with :unauthorized }
      end
    end
  end

  describe 'GET #show' do
    context 'When an user is authenticated' do
      include_context 'With an authenticated User'
      context 'When searching for a book' do
        let(:book) { create(:book) }
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

      context 'when searching for an unexisting book' do
        let(:book) { create(:book, id: 1) }
        let(:searched_id) { 2 }
        before { get :show, params: { id: searched_id } }

        it { is_expected.to respond_with :not_found }
      end
    end

    context 'without an authenticated user' do
      context 'When fetching a book' do
        let(:book) { create(:book) }
        before { get :show, params: { id: book.id } }

        it { is_expected.to respond_with :unauthorized }
      end
    end
  end
end
