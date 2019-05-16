require 'rails_helper'
require_relative 'shared_context'

describe BooksController do
  describe 'GET #index' do
    context 'When an user is authenticated' do
      include_context 'Authenticated User'
      let!(:books) { create_list(:book, 5) }
      context 'When fetching all the books' do
        before { get :index }

        it 'responses with the books json' do
          expected = ActiveModel::Serializer::CollectionSerializer.new(
            books, each_serializer: BookPreviewSerializer
          ).to_json
          expect(response.body.to_json) =~ JSON.parse(expected)
        end

        it { is_expected.to respond_with :ok }
      end
    end
    context 'When there is not an authenticated user' do
      context 'When fetching all the books' do
        before { get :index }
        it { is_expected.to respond_with :unauthorized }
      end
    end
  end
end
