class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def microsoft_graph
    auth = request.env["omniauth.auth"]

    if @u = User.find_by_email(auth.info.email)
      if @u.provider != ""
        sign_in(@u)
        if @u.persisted?
          sign_in_and_redirect @u, event: :authentication #this will throw if @user is not activated
          set_flash_message(:notice, :success, kind: "Microsoft Office") if is_navigational_format?
        else
          #this catches accounts that already exist
          redirect_to "/merge_account_with_oauth/notice", flash: { data: auth.info, new_provider: auth.provider, new_uid: auth.uid, user: @u }
      end
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
