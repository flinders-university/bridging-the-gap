class MergeAccountWithOauthController < ApplicationController
  def notice
    Rails.logger.fatal("Reached merge account with: #{flash.inspect}")
    if !flash[:data]
      redirect_to "/users/sign_in", notice: "Data missing. Please log in using your account manually."
    else
      data = flash[:data]
      user = flash[:user]
      new_provider = flash[:new_provider]
      new_uid = flash[:new_uid]
    end
  end
end
