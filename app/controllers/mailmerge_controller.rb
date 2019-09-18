class MailmergeController < ApplicationController
  before_action :require_administrator!
  
  def postmaster
    raise params
  end

  def preview
    render :layout => false
  end
end
