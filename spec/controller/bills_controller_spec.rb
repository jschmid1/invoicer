require 'rails_helper'

RSpec.describe BillsController, type: :controller  do
  describe 'GET #index' do

    it 'renders template index' do
      login_as(build(:user), :scope => :user, :run_callbacks => false)
      get bills_path
      expect(response).to render_template :index
    end

    it 'has a 200 status code' do
      login_as(build(:user), :scope => :user, :run_callbacks => false)
      bill = build(:bill)
      get bills_path
      expect(response.status).to eq(200)
    end

    it 'will test the calculate_balance method' do
    end
  end
end
