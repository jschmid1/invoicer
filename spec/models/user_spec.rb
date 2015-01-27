require 'rails_helper'

describe 'User' do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it 'is not valid without a name' do
    expect(FactoryGirl.build(:user, name: nil)).to be_valid
  end
  it 'will take email addr ess only if matches regex'
  it 'will force you to put in a name'
  it 'has a password with more than 8 characters'
  it 'has a password_confirmation that matches password'
  it 'could have a custom avatar, but always a default avatar'
end
