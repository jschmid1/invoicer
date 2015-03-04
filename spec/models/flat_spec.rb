require 'rails_helper'

describe Flat do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:flat)).to be_valid
  end

  it 'will be saved with a name' do
    subject.name = 'Test'
    expect(subject).to be_valid
  end


  it 'will not to be saved without a name' do
    expect(subject).to be_invalid
  end

  it { should have_many(:users) }

  it { should have_many(:invites) }

  it { should have_many(:tasks) }

  it { should have_one(:owner).class_name('User') }

end




