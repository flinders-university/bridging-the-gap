class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  def create
    params[:user][:group_id] = Group.find_by_name("General").id
    super
  end

  private

  def check_captcha
    unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors besides Recaptcha
        set_minimum_password_length
        respond_with resource
      end
  end

  def after_sign_up_path_for(resource)
    url_for getting_started_welcome_path
  end

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :group_id)
  end

  def account_update_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password, :gender, :age, :degree, :major, :minor)
  end
end
