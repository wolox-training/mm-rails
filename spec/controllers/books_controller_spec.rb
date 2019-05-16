require 'rails_helper'
require_relative 'shared_context'

describe BooksController do
  def response_body
    JSON.parse(response.body)
  end

  it { is_expected.to route(:get, '/books').to(action: :index) }
  it { is_expected.to route(:get, '/books/1').to(action: :show, id: 1) }

  describe 'GET #index' do
    context 'When an user is authenticated' do
      include_context 'Authenticated User'
      let!(:books) { create_list(:book, 5) }
      context 'When fetching all the books' do
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
            books, each_serializer: BookPreviewSerializer
          ).to_json
          expect(response_body['page']) =~ JSON.parse(expected)
        end
      end

      context 'When fetching with a limit=2 parameter' do
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
