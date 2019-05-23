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
    end

    context 'when posting an invalid book suggestion' do
      let(:book_suggestion) { attributes_for(:book_suggestion).merge(year: 'invalid') }

      before { http_response }

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'responses with a json' do
        expect(response.content_type).to eq 'application/json'
      end
    end
  end
=======
RSpec.describe BookSuggestionsController, type: :controller do
>>>>>>> 0b05997... Adding books_controller#create and post route
end
