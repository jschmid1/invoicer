class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  def leave_flat
    @user = User.find(current_user)
    @user.update(flat_id: nil)
    flash.alert = "Successfully left Flat"
    redirect_to root_path
  end
end