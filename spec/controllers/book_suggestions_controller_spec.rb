require 'rails_helper'

describe BookSuggestionsController do
  describe 'POST #create' do
    subject(:http_response) { post :create, params: { book_suggestion: book_suggestion } }

    context 'when posting a new book suggestion' do
      let(:book_suggestion) do
        {
          synopsis: 'Una Sinopsis',
          author: 'Tincho',
          title: 'UnLibro',
          link: 'wikipedia.com',
          publisher: 'SuperBooks',
          year: '1998',
          price: 2313.23
        }
      end

      before { http_response }

      it { is_expected.to have_http_status :created }

      it 'responses with a json' do
        expect(response.content_type).to eq 'application/json'
      end
    end

    context 'when posting an invalid book suggestion' do
      let(:book_suggestion) do
        {
          synopsis: 'Una Sinopsis',
          author: 'Tincho',
          title: 'UnLibro',
          link: 'wikipedia.com',
          year: '1998',
          price: 2313.23
        }
      end

      before { http_response }

      it { is_expected.to have_http_status :unprocessable_entity }

      it 'responses with a json' do
        expect(response.content_type).to eq 'application/json'
      end
    end
  end
end
