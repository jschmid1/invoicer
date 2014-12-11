class InviteMailer < ActionMailer::Base
  default from: "invite@wgserv.eu"

  def new_user_invite(invite, url)
      @invite = invite
      @url  = url
      mail(to: @invite.email, subject: 'Pending Invitation for Invoicer')
  end
end
