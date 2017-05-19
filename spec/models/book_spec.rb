require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'valid inputs' do
    it 'saves if valid' do
      @book = build(:book)
      expect(@book.save).to eq(true)
      expect(Book.last).to eq(@book)
    end
    it 'has author' do
      @book = create(:book)
      expect(@book.author.name).to eq("Some repressed chick")
    end
  end

  context 'invalid inputs' do
    it 'does not save with empty title' do
      @book = build(:book, title:'')
      expect(@book.save).to eq(false)
    end
    it 'does not save with empty author' do
      @book = build(:book, author:nil)
      expect(@book.save).to eq(false)
    end
  end
  


end
