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

end
