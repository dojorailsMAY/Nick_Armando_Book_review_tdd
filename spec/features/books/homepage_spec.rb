require 'rails_helper'

feature 'Homepage' do
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

    visit '/books'
  end


  scenario 'displays recent book reviews' do

    expect(page).to have_content "Recent Book Reviews:"
    expect(page).to have_content "Book_title"
    expect(page).to have_content "Book sucks"
    expect(page).to have_content "Rating: 3"
    expect(page).to have_selector('.review', count: 3)
    expect(page).to have_no_content "Should not show up"


  end

  scenario 'displays other books with reviews' do

    expect(page).to have_selector('.other-books', count:3)

  end




end
