require 'rails_helper'

describe Bill do

  it { should have_many(:involved_in_bills) }

  it { should have_many(:users) }

  # it { should have_one(:market) }

end