require 'rails_helper'

describe RentsController do
  let!(:starting_date) { Date.new 2017, 1, 1 }
  let!(:ending_date) { Date.new 2018, 1, 1 }
  let!(:book) { create :book }
  let!(:book2) { create :book }
  describe 'GET #index' do
    subject(:http_response) { get :index, params: { user_id: current_user.id } }

    context 'when an user is authenticated' do
      include_context 'With an authenticated User'
      let!(:rent1) do
        Rent.create book: book, user: current_user,
                    starting_date: starting_date, ending_date: ending_date
      end
      let!(:rent2) do
        Rent.create book: book2, user: current_user,
                    starting_date: starting_date, ending_date: ending_date
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
            [rent1, rent2],
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
    let(:rent_json) do
      { book_id: book.id, user_id: current_user.id,
        starting_date: starting_date, ending_date: ending_date }
    end
    context 'with an authenticated user' do
      include_context 'With an authenticated User'
      context 'when posting a new rent' do
        before { http_response }

        it { is_expected.to have_http_status :created }

        it 'responses with a json' do
          expect(response.content_type).to eq 'application/json'
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
