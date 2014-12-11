class RegistrationsController < Devise::RegistrationsController

  def new
    @token = params[:invite_token] #<-- pulls the value from the url query string
    super
  end

  def create
    @user = User.new(user_params)
    @token = params[:invite_token]
    if @token != nil
      org = Invite.find_by_token(@token).flat
      @user.flat_id = org.id
    end
    @user.save
    set_flash_message :notice, :signed_up if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_up_path_for(resource)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :created_at, :password, :password_confirmation, :token)
  end
end