require 'rails_helper'

RSpec.describe User, type: :model do
  context ' with valid input' do
    it 'saves and is valid' do
      @user = build(:user)
      expect(@user).to be_valid
      @user.save
      expect(@user).to eq(User.last)
    end

  end
  context 'with invalid input' do

    it 'does not save without first name ' do
      @user = build(:user, first_name:'')
      expect(@user.save).to eq(false)
    end
    it 'does not save without last name ' do
      @user = build(:user, last_name:'')
      expect(@user.save).to eq(false)
    end
    it 'does not save without email ' do
      @user = build(:user, email:'')
      expect(@user.save).to eq(false)
    end
    it 'does not save without password' do
      @user = build(:user,password:"")
      expect(@user.save).to eq(false)
    end
    it 'does not save without password confirmation' do
      @user = build(:user,password_confirmation:"")
      expect(@user.save).to eq(false)
    end

    it 'does not save without valid email format' do

      @user1 = build(:user, email: "nick@gmail")
      expect(@user1.save).to eq(false)
      @user2 = build(:user, email: "@gmail.com")
      expect(@user2.save).to eq(false)
      @user3 = build(:user, email: "nickgmail.com")
      expect(@user3.save).to eq(false)

    end

    it 'does not save if email already exists' do

      @user1 = create(:user)
      @user2 = build(:user)
      expect(@user2.save).to eq(false)

    end

    it 'does not save unless passwords match' do

      @user = build(:user, password:"nomatch")
      expect(@user.save).to eq(false)
      @user2 = build(:user, password_confirmation:"nomatch")
      expect(@user2.save).to eq(false)

    end


  end
  describe '#reviewed_books' do
    it 'works' do
      @user = create(:user)
      @book1 = create(:book)
      @author2 = create(:author, name: "another author")
      @book2 = create(:book, title:"Something else", author: @author2)
      @author3 = create(:author, name: "A third author")
      @book3 = create(:book, title:"Another book", author: @author3)
      @review1 = create(:review, book:@book1, user: @user, content:"Should not show up")
      @review2 = create(:review, book:@book2, user: @user)
      @review3 = create(:review, book:@book3, user: @user)
      @review4 = create(:review, book:@book3, user: @user)
      expect(@user.reviewed_books.count).to eq(3) 
    end
  end
end
