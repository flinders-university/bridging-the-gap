class MailmergeController < ApplicationController
  def postmaster
    raise params
  end

  def preview
    render :layout => false
  end
end
