require 'rails_helper'

feature 'Profile Page' do
  before(:each) do
    register
    @user = User.last
    @book1 = create(:book)
    @author2 = create(:author, name: "another author")
    @book2 = create(:book, title:"Something else", author: @author2)
    @author3 = create(:author, name: "A third author")
    @book3 = create(:book, title:"Another book", author: @author3)
    @review1 = create(:review, book:@book1, user: @user, content:"Should not show up")
    @review2 = create(:review, book:@book2, user: @user)
    @review3 = create(:review, book:@book3, user: @user)
    @review4 = create(:review, book:@book3, user: @user)
    visit '/users/%s' % @user.id
  end

  scenario 'display user info' do
    expect(page).to have_current_path '/users/%s' % @user.id
    expect(page).to have_content 'Name: %s %s' % [@user.first_name, @user.last_name]
    expect(page).to have_content 'Email: %s' % [@user.email]
    expect(page).to have_content 'Total Reviews: %s' % [@user.reviews.count]
  end
  scenario 'display nav links' do
    expect(page).to have_link 'Home'
    expect(page).to have_link 'Add Book and Review'
    expect(page).to have_button 'Logout'
  end
  scenario 'show books reviewed by user' do
    expect(page).to have_content 'Posted Reviews on the following books'

  end

end
