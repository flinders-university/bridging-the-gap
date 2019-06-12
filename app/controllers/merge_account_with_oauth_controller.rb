class MergeAccountWithOauthController < ApplicationController
  def notice
    if !data
      redirect_to "/users/sign_in", notice: "Data AWOL"
    end
  end
end
