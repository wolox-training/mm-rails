require 'rails_helper'

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
      let(:book_suggestion) { attributes_for(:book_suggestion, year: Faker::TvShows::Simpsons.character, title: nil) }

      before { http_response }

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'responses with a json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'does not create a new book suggestion' do
        expect do
          post :create, params: { book_suggestion: book_suggestion }
        end.not_to(change { BookSuggestion.count })
      end

      it 'returns error messages' do
        expect(response_body['errors']).to be_present
      end

      it 'responses with title error message' do
        error_msg = 'can\'t be blank'
        expect(response_body['errors']['title']).to include error_msg
      end

      it 'responses with year error message' do
        error_msg = 'is not a number'
        expect(response_body['errors']['year']).to include error_msg
      end
    end
  end
end
