class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def microsoft_graph
    auth = request.env["omniauth.auth"]

    if @u = User.find_by_email(auth.info.email)
      #this catches accounts that already exist
      redirect_to controller: 'merge_account_with_oauth', action: 'notice', data: auth.info, new_provider: auth.provider, new_uid: auth.uid, user: @u
      false
    else
      # new accounts
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in(@user)
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Microsoft Office") if is_navigational_format?
      else
        #session["devise.microsoft_graph"] = request.env["omniauth.auth"]
        Rails.logger.fatal("Request response from MS AD object: #{request.env["omniauth.auth"]}")
        redirect_to new_user_session_path, notice: "#{request.env["omniauth.auth.info"]}"
      end
    end
  end

  def failure
    redirect_to root_path
  end
end
