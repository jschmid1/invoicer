require 'rails_helper'

describe Event do
  # it { should have_one(:creator).class_name('User') }

  it { should have_and_belong_to_many(:users) }

end
