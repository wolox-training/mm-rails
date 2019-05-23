require 'rails_helper'

<<<<<<< HEAD
describe BookSuggestionsController do
  describe 'POST #create' do
    subject(:http_response) { post :create, params: { book_suggestion: book_suggestion } }

    context 'when posting a new book suggestion' do
      let(:book_suggestion) { attributes_for(:book_suggestion) }

      before { http_response }

      it { is_expected.to have_http_status :created }

      it 'responses with a json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'creates a new book suggestion' do
        expect do
          post :create, params: { book_suggestion: book_suggestion }
        end.to change { BookSuggestion.count }.by(1)
      end
    end

    context 'when posting an invalid book suggestion' do
<<<<<<< HEAD
      let(:book_suggestion) { attributes_for(:book_suggestion).merge(year: 'invalid') }
=======
      let(:book_suggestion) { attributes_for(:book_suggestion, year: 'dsaf', title: nil) }
>>>>>>> 5c6edb9... Adding book_suggestion controller test cases

      before { http_response }

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'responses with a json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'does not create a new book suggestion' do
        expect do
          post :create, params: { book_suggestion: book_suggestion }
        end.to change { BookSuggestion.count }.by(0)
      end

      it 'returns error messages' do
        expect(response_body['errors']).to be_present
      end
    end
  end
=======
RSpec.describe BookSuggestionsController, type: :controller do
>>>>>>> 0b05997... Adding books_controller#create and post route
end
