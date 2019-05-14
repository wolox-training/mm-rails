require 'rails_helper'

describe Book do
  subject(:book) { build(:book) }
  subject(:invalid_year_book) { build(:book, year: '125.4') }
  subject(:missing_author_book) { build(:book, author: nil) }
  subject(:empty_title_book) { build(:book, title: '') }
  subject(:empty_genre_book) { build(:book, genre: '') }
  subject(:empty_publisher_book) { build(:book, publisher: '') }
  subject(:missing_image_book) { build(:book, image: nil) }

  describe '#save' do
    context 'When the book is created' do
      it 'generates an id' do
        book.save!
        expect(book.id).to be_present
      end
    end

    context 'when year is invalid' do
      it 'fails at save' do
        expect { invalid_year_book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when author is missing' do
      it 'fails at save' do
        expect { missing_author_book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when title is empty' do
      it 'fails at save' do
        expect { empty_title_book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when genre is empty' do
      it 'fails at save' do
        expect { empty_genre_book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when publisher is empty' do
      it 'fails at save' do
        expect { empty_publisher_book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when image is missing' do
      it 'fails at save' do
        expect { missing_image_book.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
