class GettingStartedController < ApplicationController
  before_action :authenticate_user!, except: [:information]

  def information
    if current_user.present?
      redirect_to getting_started_welcome_path
    end
  end

  def welcome

  end
end
