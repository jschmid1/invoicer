require 'rails_helper'

describe Bill do


  it 'wont be saved with a value set but witout a market_id' do
    subject.value = 8 
    expect(subject).to be_invalid
  end

  it 'wont be save without a value' do
    expect(subject).to be_invalid
  end

  it 'will be saved with value and market_id set' do
    subject.value = 8
    subject.market_id = 1
    expect(subject).to be_valid
  end

  it { should have_many(:involved_in_bills) }

  it { should have_many(:users) }

  # it { should have_one(:market) }

end
