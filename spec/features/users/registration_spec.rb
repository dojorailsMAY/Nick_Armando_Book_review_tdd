require 'rails_helper'

feature 'registration feature'do

  feature 'user attempts to register'do
    scenario 'visits register page, has necessary inputfields' do
      visit '/sessions/new'
      expect(page).to have_content("First Name")
      expect(page).to have_content("Last Name")
      expect(page).to have_content("Confirm Password")
      expect(page).to have_field('user[first_name]')
      expect(page).to have_field('user[last_name]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[email]')
      expect(page).to have_button('Register')
    end

    scenario 'valid registration' do
      register
      expect(page).to have_current_path('/books')
      expect(page).to have_button("Logout")
      expect(page).to have_link "Add Book and Review"
      expect(page).to have_content "Welcome, John"
    end

    scenario 'with blank first name' do
      register first_name:""
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "First name can't be blank"
    end
    scenario 'with blank last name' do
      register last_name:""
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "Last name can't be blank"
    end
    scenario 'with invalid email' do
      register email:""
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "Email can't be blank"
      register email:"mjnbvrce"
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "Please enter a valid email"
      register email:"mjnbvrce@"
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "Please enter a valid email"
      register email:"mjnbvrce@hgfds"
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "Please enter a valid email"

    end

    scenario 'with blank password' do
      register password:""
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "Password can't be blank"
    end
    scenario 'with invalid password_confirmation' do
      register password_confirmation:""
      expect(page).to have_current_path "/sessions/new"
      expect(page).to have_content "Password confirmation doesn't match"
    end
  end

end
