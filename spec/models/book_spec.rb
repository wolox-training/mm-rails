require 'rails_helper'

describe Book do
  subject(:book) { build(:book) }
  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :genre }
  it { is_expected.to validate_presence_of :author }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :publisher }
  it { is_expected.to validate_presence_of :image }
  it { is_expected.to validate_numericality_of(:year).only_integer }

  describe '#save' do
    subject(:save) { book.save }
    context 'When the book is created' do
      it 'Generates an id' do
        book.save!
        expect(book.id).to be_present
      end
    end
  end
end
