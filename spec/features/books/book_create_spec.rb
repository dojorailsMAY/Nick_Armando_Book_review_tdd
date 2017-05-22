require 'rails_helper'

feature 'Book creation page' do
    before(:each) do
        register
        @user = User.last
        @book1 = create(:book)
        @author1 = create(:author, name:"Jane")
        @author2 = create(:author, name:"Jacky")
        visit '/books/new'
    end

    scenario 'display all necessary html besides the form' do
        expect(page).to have_link 'home'
        expect(page).to have_button 'Logout'
        expect(page).to have_content 'Add a new Book Title and Review'
    end

    scenario 'display all compenents of book addition form' do
        expect(page).to have_content('Book Title: ')
        expect(page).to have_content("Author: ")
        expect(page).to have_content("Choose from the List: ")
        expect(page).to have_content("Or add new author:")
        expect(page).to have_content("Review:")
        expect(page).to have_content("Rating:")
        expect(page).to have_field('book_title')
        expect(page).to have_field('book_author')
        expect(page).to have_field('book_new_author')
        expect(page).to have_field('book_review')
        expect(page).to have_field('book_rating')
        expect(page).to have_button("Add Book and Review")
    end
    feature 'submitting valid form' do 
        scenario 'with existing Author' do
            create_new_book_and_review
            expect(page).to have_content("newbook")
            expect(page).to have_content("new_author")
            expect(page).to have_content('Add a Review')
            expect(page).to have_field('content')
            expect(page).to have_field('rating')
            expect(page).to have_button('Submit Review')
        end
        scenario 'with new author' do  #test incomplete! Ask Nick Monday
            create_new_book_and_review_with_existing_author
            expect(page).to have_content("newbook")
            expect(page).to have_content("new_author")
            expect(page).to have_content('Add a Review')
            expect(page).to have_field('content')
            expect(page).to have_field('rating')
            expect(page).to have_button('Submit Review')
        end

    end
    feature 'submitting invalid input' do
        scenario 'invalid title' do #Flash message wont appear
            create_new_book_and_review title:""
            expect(page).to have_current_path "/books/new"
            expect(page).to have_content "Title can't be blank"
        end
        scenario 'invalid author input' do #Author inputs ask with nick
            create_new_book_and_review new_author:""
            expect(page).to have_current_path "/books/new"
            expect(page).to have_content "Please select an existing author or add a new one"
        end
        scenario 'empty review form' do
            create_new_book_and_review review:''
             
            expect(page).to have_current_path "/books/new"
            expect(page).to have_content "Content can't be blank"
        end

    end
    scenario 'has multiple authors in select dropdown' do
        expect(page).to have_content("Jane")
        expect(page).to have_content("Jacky")

    end
end