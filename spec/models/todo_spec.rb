require 'rails_helper'


describe Todo do

  describe 'validation' do

    it 'wont be saved without a task' do 
      expect(subject).to be_invalid
    end

    it 'will be saved with a task' do 
      subject.task = "Testing rails"
      expect(subject).to be_valid
    end

  end

  it { should belong_to(:user) }

end
