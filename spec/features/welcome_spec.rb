require 'rails_helper'

describe 'Feature tests' do
  describe 'home page' do
    it 'welcomes the user' do
      visit '/'
      expect(page).to have_content "Invoicer"
      expect(page).to have_content "Login"
    end
  end
end
