class DataControllerController < ApplicationController
  before_action :require_administrator!

  def delete
    u = User.find_by_email(params[:email])
    if u.present?
      u.industry_id = nil
      if u.save
        redirect_to "/usertools/#{u.id}", notice: "Deallocated placement"
      else
        redirect_to "/usertools/#{u.id}", notice: "Could not deallocate placement"
      end
    end
  end
end
