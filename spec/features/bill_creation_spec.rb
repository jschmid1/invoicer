require 'rails_helper'

describe 'create a bill', :type => :feature do
  before :each do
    User.create(:email => 'user@example.com', :password => 'password1234', :password_confirmation => 'password1234', :name => "lattelol")
  end

  feature 'Create Bill' do
    scenario 'login' do
      sign_up_with 'user@example.com', 'password1234'
      expect(page).to have_content('successfully.')
      visit new_bill_path
      expect(page).to have_content('Create New Bill')
      fill_in 'Value', with: 1
      click_button 'Create Bill'
      expect(page).to have_content('error prohibited this bill from being saved: Market')
      visit new_bill_path
      fill_in 'Value', with: 1
      page.select 'Aldi', :from => 'Market'
      click_button 'Create Bill'
      expect(page).to have_content('Succesfully created Bill Value')
    end

    def sign_up_with(email, password)
      visit user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end
  end
end