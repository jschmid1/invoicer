require 'rails_helper'

describe BillsController, type: :controller  do
  describe 'index' do

    before :each do
      user= FactoryGirl.create(:user)
      sign_in user
    end

    it 'cant get all the bills because not logged in' do
      byebug
      get "/bills"
      expect(response).to be_success
    end


  end
  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
