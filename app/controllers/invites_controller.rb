class InvitesController < ApplicationController

  respond_to :html

  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id
    @invite.flat_id = current_user.flat_id
    if @invite.save
      InviteMailer.new_user_invite(@invite, new_user_registration_url(:invite_token => @invite.token)).deliver
      flash[:notice] = "Thank you, invitation sent."
    else
      flash[:notice] = "Something went wrong"
    end
    redirect_to root_url
  end

  def new
    @invite = Invite.new
    @invite.sender_id = current_user.id
    respond_with(@invite)
  end

  def index
    render 'index'
  end

  private

  def invite_params
    params.require(:invite).permit(:flat_id, :email)
  end
end
