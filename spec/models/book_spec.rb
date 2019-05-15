require 'rails_helper'

describe Book do
  subject(:book) { build(:book) }

  describe '#save' do
    subject(:save) { book.save }
    context 'When the book is created' do
      it 'generates an id' do
        book.save!
        expect(book.id).to be_present
      end
    end

    context 'when year is invalid' do
      let(:book) { build(:book, year: '125.4') }
      it 'fails at save' do
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when author is missing' do
      let(:book) { build(:book, author: nil) }
      it 'fails at save' do
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when title is empty' do
      let(:book) { build(:book, title: '') }
      it 'fails at save' do
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when genre is empty' do
      let(:book) { build(:book, genre: '') }
      it 'fails at save' do
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when publisher is empty' do
      let(:book) { build(:book, publisher: '') }
      it 'fails at save' do
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when image is missing' do
      let(:book) { build(:book, image: nil) }
      it 'fails at save' do
        expect { book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
