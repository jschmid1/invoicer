class InviteMailer < ActionMailer::Base
  default from: "invoicer@wgserv.eu"

  def new_user_invite(invite, url)
    @invite = invite
    @url  = url
    mail(to: @invite.email, subject: 'Pending Invitation for Invoicer')
  end

  def existing_user_invite(invite)
    @invite = invite
    mail(to: @invite.email, subject: 'Pending invitation for Invoicer')
  end

end
