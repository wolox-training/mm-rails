require 'rails_helper'

describe Book do
  subject(:book) { build(:book) }

  describe '#id' do
    context 'When the book is created' do
      it 'generates an id' do
        book.save!
        expect(book.id).to be_present
      end
    end
  end
end
