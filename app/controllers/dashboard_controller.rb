class DashboardController < ApplicationController

  def index
    @user = User.all
    render 'index'
  end

  def user
    @user = User.all
  end

end
