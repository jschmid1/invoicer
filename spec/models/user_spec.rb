require 'rails_helper'
describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it 'is not valid without a name' do
    expect(FactoryGirl.build(:user, name: nil)).to be_invalid
  end
  it 'will take email addr ess only if matches regex' do
    expect(FactoryGirl.build(:user, email: "novailidmailpattern")).to be_invalid
  end
  it 'will accept mailaddr in correct pattern' do
    expect(FactoryGirl.build(:user, email: "test@test.de")).to be_valid
  end
  it 'has a password with more than 8 characters' do
    expect(FactoryGirl.build(:user, password: "12345")).to be_invalid
  end
  it 'has a password_confirmation that matches password' do
    expect(FactoryGirl.build(:user, password: "1234", password_confirmation: "12345")).to be_invalid
  end
  it 'could have a custom avatar, but always a default avatar'
end
