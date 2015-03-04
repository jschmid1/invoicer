require 'rails_helper'

describe "the signin process", :type => :feature do
  before :each do
    User.create(:email => 'user@example.com', :password => 'password1234', :password_confirmation => 'password1234', :name => "lattelol")
  end


  feature 'Visitor signs up' do
    scenario 'with valid email and password but no account' do
      sign_up_with 'no@account.yet', 'password1234'
      expect(page).to have_content('Invalid')
    end

    scenario 'with valid email and password and activated account' do
      sign_up_with 'user@example.com', 'password1234'
      expect(page).to have_content('successfully.')
    end


    scenario 'with invalid email' do
      sign_up_with 'invalid_email', 'password1234'
      expect(page).to have_content('Invalid')
    end

    scenario 'with blank password' do
      sign_up_with 'user@example.com', ''
      expect(page).to have_content('Invalid')
    end

    def sign_up_with(email, password)
      visit user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end
  end
end
