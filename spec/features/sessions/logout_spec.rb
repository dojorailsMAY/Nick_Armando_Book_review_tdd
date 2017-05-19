require 'rails_helper'
feature 'logout feature'do
  before(:each)do
    @user = create(:user)
  end



  feature "user attempts to log out" do

    before(:each) do
      log_in
    end

    scenario 'displays "Log Out" button when user is logged on' do
      expect(page).to have_button "Logout"
    end

    scenario 'logs out user and redirects to login page' do
      click_button "Logout"
      expect(page).to have_current_path('/sessions/new')
      # expect(session[:current_user_id]).to eq(nil)
    end
  end

end
