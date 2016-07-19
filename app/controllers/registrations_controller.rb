class RegistrationsController < Devise::RegistrationsController

  def create
    params[:user][:group_id] = Group.find_by_name("General").id
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :group_id)
  end

  def account_update_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password)
  end
end
