require 'rails_helper'



describe "A guided Tour", :type => :feature do
  before :each do
    @user = User.create(:email => 'user@example.com', :password => 'password1234', :password_confirmation => 'password1234', :name => "lattelol")
  end


  scenario 'with valid email and password and activated account' do
    sign_up_with 'user@example.com', 'password1234'
    expect(page).to have_content('successfully.')
    visit bills_path
    expect(page).to have_content('Listing bills')
    visit todos_path
    expect(page).to have_content('InCompleted')
    expect(page).to_not have_content('Admin')
    visit root_path
    expect(page).to_not have_content('List all Bills')
    expect(page).to_not have_content('Statistics')
    visit new_flat_path
    fill_in 'Name', with: 'NewFlat'
    click_button 'Create Flat'
    expect(page).to have_content('Dashboard')
  end




  def sign_up_with(email, password)
    visit user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end


end