class MergeAccountWithOauthController < ApplicationController
  def notice
    if !params[:data]
      redirect_to "/users/sign_in", notice: "Data AWOL"
    else
      data = params[:data]
      user = params[:user]
      new_provider = params[:new_provider]
      new_uid = params[:new_uid]
    end
  end
end
