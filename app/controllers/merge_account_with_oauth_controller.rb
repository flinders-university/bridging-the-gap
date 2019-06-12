class MergeAccountWithOauthController < ApplicationController
  def notice
    Rails.logger.fatal("Reached merge account with: #{flash.inspect}")
    if !flash[:data]
      redirect_to "/users/sign_in", notice: "Data missing. Please log in using your account manually."
    else
      @data = flash[:data]
      @user = flash[:user]
      @new_provider = flash[:new_provider]
      @new_uid = flash[:new_uid]
    end
  end

  def save
    usr = User.find(params[:user]['email'])
    usr.provider = params[:new_provider]
    usr.uid = params[:new_uid]
    if usr.save
      redirect_to "/users/sign_in", notice: "Account linked. Please log in."
    else
      redirect_to "/users/sign_in", notice: "Sorry, we failed to link your ADFS account."
    end
  end
end
