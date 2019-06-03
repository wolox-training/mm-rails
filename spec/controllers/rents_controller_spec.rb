require 'rails_helper'

describe RentsController do
  describe 'GET #index' do
    subject(:http_response) { get :index, params: { user_id: current_user.id } }

    context 'when an user is authenticated' do
      include_context 'With an authenticated User'
      let!(:rents) do
        create_list(:rent, 2, user: current_user)
      end

      context 'when fetching all the rents' do
        before { http_response }

        it { is_expected.to have_http_status :ok }

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
        end

        it 'responses with a paginated json' do
          expect(response_body).to be_paginated
        end

        it 'response with the user´s rents json' do
          expected = ActiveModel::Serializer::CollectionSerializer.new(
            rents,
            serializer: RentSerializer
          ).to_json
          expect(response_body['page']).to eq JSON.parse(expected)
        end
      end
    end

    include_examples 'without an authenticated user'
  end

  describe 'POST #create' do
    subject(:http_response) do
      post :create,
           params: { user_id: current_user.id,
                     rent: rent_json },
           format: :json
    end

    let!(:book) { create :book }
    let(:rent_json) { attributes_for(:rent, user_id: current_user.id, book_id: book.id) }

    context 'with an authenticated user' do
      include_context 'With an authenticated User'
      context 'when posting a new rent' do
        before { http_response }

        it { is_expected.to have_http_status :created }

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
        end

        it 'responses with the created rent json with an id' do
          expect(response_body['id']).to be_present
        end
      end

      context 'when posting an invalid rent' do
        let(:rent_json) do
          { book_id: book.id, user_id: current_user.id }
        end

        before { http_response }

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end

    include_examples 'without an authenticated user'
  end
end
