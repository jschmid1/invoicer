require 'rails_helper'
describe Flat do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:flat)).to be_valid
  end

  it 'is not valid without a name' do
    expect(FactoryGirl.build(:flat, name: nil)).to be_invalid
  end

  it { should have_many(:users) }

  it { should have_many(:invites) }

  it { should have_many(:tasks) }

  it { should have_one(:owner).class_name('User') }

end




