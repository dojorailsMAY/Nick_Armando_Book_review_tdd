require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'valid input' do
    it 'saves to database' do
      @review = create(:review)
      expect(@review.save).to eq(true)
    end
    it 'has access to book' do
      @review = create(:review)
      expect(@review.book.title).to eq('Book_title')
    end
    it "has access to user" do
      @review = create(:review)
      expect(@review.user.first_name).to eq('John')
    end
  end
  context 'invalid input' do
    it 'doesnt save without content' do
      @review = build(:review, content:'')
      expect(@review.save).to eq(false)
    end
    it 'doesnt save without book' do
      @review = build(:review, book:nil)
      expect(@review.save).to eq(false)
    end
    it 'doesnt save without user' do
      @review = build(:review, user:nil)
      expect(@review.save).to eq(false)
    end

  end
end
