require 'rails_helper'

feature 'Book creation page' do
  before(:each) do
    @user2 = create(:user, first_name:"Jane", email:'jane@doe.com')
    @user3 = create(:user, first_name:"Joe", email:'joe@doe.com')
    register
    @user = User.last
    @book1 = create(:book)
    create(:review, book:@book1, user: @user)
    create(:review, book:@book1, user: @user2, rating:4)
    create(:review, book:@book1, user: @user3, rating: 5)
    create(:review, book:@book1, user: @user, rating: 1)
    visit '/books/%s' % @book1.id
  end

  scenario 'displays book title and author' do
    expect(page).to have_content(@book1.title)
    expect(page).to have_content(@book1.author.name)
  end

  scenario 'displays all reviews on book' do
    expect(page).to have_selector('.review', count:@book1.reviews.count)
    expect(page).to have_content(1,3,4,5)
  end

  scenario 'displays add review form' do
    expect(page).to have_content('Add a Review')
    expect(page).to have_field('content')
    expect(page).to have_field('rating')
    expect(page).to have_button('Submit Review')
  end

end
