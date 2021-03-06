class DashboardController < ApplicationController

  def index
    @user = User.where(flat_id: current_user.flat_id)
    # @user = User.all
    render 'index'
  end

  def welcome
    if user_signed_in? && current_user.flat_id
      render 'dashboard/graphs'
    elsif user_signed_in?
      render 'dashboard/instructions'
    else
      render 'welcome'
    end
  end

  def graphs
    render 'dashboard/graphs'
  end

  def admin
    @all_flats = Flat.all
    @all_users = User.all
    render 'dashboard/admin'
  end

  def statistics
    @bills_per_month = Bill.where(created_at: Time.now-30.days..Time.now).where(user_id: User.where(flat_id: current_user.flat_id))
    @bills_this_month = Bill.where(created_at: (Time.now-(Time.now.day).days)..Time.now).where(user_id: User.where(flat_id: current_user.flat_id))
    render 'dashboard/statistics'
  end

end
