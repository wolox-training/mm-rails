require 'rails_helper'

describe Book do
  subject(:book) { build(:book) }

  # it { is_expected.to be_valid }
  # it { is_expected.to validate_presence_of(:first_name) }
  # it { is_expected.to validate_presence_of(:last_name) }

  describe '#generate_verification_code' do
    context 'When the book is created' do
      it 'generates an id' do
        book.save!
        expect(book.id).to be_present
      end
    end
  end
end
