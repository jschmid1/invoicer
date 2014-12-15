class DashboardController < ApplicationController

  def index
    @user = User.where(flat_id: current_user.flat_id)
    # @user = User.all
    render 'index'
  end

  def welcome
    render 'welcome'
  end

  def graphs
    render 'dashboard/graphs'
  end

  def statistics
    @bills_per_month = Bill.where(created_at: Time.now-30.days..Time.now).where(user_id: User.where(flat_id: current_user.flat_id))
    render 'dashboard/statistics'
  end

end
