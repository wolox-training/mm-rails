require 'rails_helper'

describe BookSuggestion do
  subject(:book_suggestion) { build(:book_suggestion) }
  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :author }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :link }
  it { is_expected.to validate_presence_of :publisher }
  it { is_expected.to validate_numericality_of(:year).only_integer }
  it { is_expected.to validate_url_of :link }

  describe '#save' do
    context 'when saving a valid book suggestion' do
      it 'generates an id' do
        book_suggestion.save!
        expect(book_suggestion.id).to be_present
      end
    end
  end
end
