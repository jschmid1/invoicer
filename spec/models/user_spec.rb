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
    expect(FactoryGirl.build(:user, email: "test@test.dee")).to be_valid
  end

  it 'has a password with more than 8 characters' do
    expect(FactoryGirl.build(:user, password: "12345")).to be_invalid
  end

  it 'has a password_confirmation that matches password' do
    expect(FactoryGirl.build(:user, password: "1234", password_confirmation: "12345")).to be_invalid
  end

  it { should have_many(:bills) }

  it { should have_many(:todos) }

  it { should have_many(:tasks) }

  it { should have_and_belong_to_many(:events) }

  it { should have_many(:working_on_tasks) }

  it { should have_many(:invitations).class_name('Invite') }

  it { should have_many(:sent_invites).class_name('Invite') }

  it { should belong_to(:flat) }

  let!(:user) { build(:user) }

  it 'asd' do
    expect(user.admin).to eq false
  end


end
