require 'rails_helper'


describe Todo do

  describe 'validation' do

    it 'should have a present task before creation <true>' do
      expect(FactoryGirl.build(:flat)).to be_valid
    end

    it 'wont be saved without a taskname' do
      expect(Todo.create(task: nil)).to be_invalid
    end

  end

  describe 'factory' do

    it 'should have a valid factory' do
      subject { FactoryGirl.build(:flat) }
    end

  end

  it { should belong_to(:user) }

end