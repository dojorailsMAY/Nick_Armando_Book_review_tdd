require 'rails_helper'

feature 'On the book page,' do
  before(:each) do
      register
      @user = User.last
      @book = create(:book)
      visit '/books/%s' % @book.id
  end

  feature 'user attempts to create review with valid inputs -' do

    scenario 'review is successfully created' do

      add_review_on_book_page

      expect(page).to have_current_path '/books/%s' % @book.id
      expect(page).to have_content "This is a book review"
      expect(page).to have_content "Rating: 5"
      expect(page).to have_selector('.review', count: 1)

      add_review_on_book_page content: "This is another book review", rating: 4
      expect(page).to have_content "This is another book review"
      expect(page).to have_content "Rating: 4"
      expect(page).to have_selector('.review', count: 2)

    end

  end

  feature 'user attempts to create review with invalid inputs - ' do

    scenario 'content is left blank' do

      add_review_on_book_page content: ""
      expect(page).to have_current_path '/books/%s' % @book.id
      expect(page).to have_no_content "This is a book review"
      expect(page).to have_no_selector ".review"
      expect(page).to have_content "Content can't be blank"


    end

    scenario 'rating is left blank' do
      add_review_on_book_page rating: 'Please choose'
      expect(page).to have_current_path '/books/%s' % @book.id
      expect(page).to have_no_content "This is a book review"
      expect(page).to have_no_selector ".review"
      expect(page).to have_content "Rating is required"

    end





  end






end
