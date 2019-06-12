class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def microsoft_graph
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Microsoft Office") if is_navigational_format?
    else
      #session["devise.microsoft_graph"] = request.env["omniauth.auth"]
      Rails.logger.debug("Request response from MS AD object: #{request.env["omniauth.auth"]}")
      redirect_to new_user_session_path, notice: "#{request.env["omniauth.auth.info"]}"
    end
  end

  def failure
    redirect_to root_path
  end
end
