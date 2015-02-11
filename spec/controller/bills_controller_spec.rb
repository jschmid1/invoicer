require 'rails_helper'

describe BillsController, type: :controller  do
  describe 'GET #index' do


    it 'renders template index' do
      login_as(build(:user), :scope => :user, :run_callbacks => false)
      get bills_path
      expect(response).to render_template :index
    end

    it 'assignes bills correctly' do
      bill = build(:bill)
      get bills_path
      assigns(:bill).should eq([bill])
    end

  end

end
