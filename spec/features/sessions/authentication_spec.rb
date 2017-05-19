require 'rails_helper'

feature 'authetication feature'do
  before(:each)do
    @user = create(:user)
  end
  feature 'user attempts login'do
    scenario 'visits sign-in page, has necessary inputfields' do
      visit '/sessions/new'
      expect(page).to have_content("Email:")
      expect(page).to have_content("Password:")
      expect(page).to have_field("email")
      expect(page).to have_field("password")
    end
    scenario 'successfully logs in if input valid' do
      log_in
      expect(page).to have_current_path('/books')
      expect(page).to have_content('Welcome, John')
      expect(page).to have_button('Logout')
      expect(page).to have_link('Add Book and Review')
    end
    scenario 'doesnt log in if email is invalid' do
      log_in email:""
      expect(page).to have_current_path '/sessions/new'
      expect(page).to have_content 'Invalid Email or Password'
    end
    scenario 'doesnt log in if password is invalid' do
      log_in password:''
      expect(page).to have_current_path '/sessions/new'
      expect(page).to have_content 'Invalid Email or Password'
    end



  end
end
