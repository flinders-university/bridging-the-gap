class MergeAccountWithOauthController < ApplicationController
  def notice
    Rails.logger.fatal("Reached merge account with: #{params.inspect}")
    if !params[:data]
      redirect_to "/users/sign_in", notice: "Data missing. Please log in using your account manually."
    else
      data = params[:data]
      user = params[:user]
      new_provider = params[:new_provider]
      new_uid = params[:new_uid]
    end
  end
end
