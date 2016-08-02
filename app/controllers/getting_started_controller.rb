class GettingStartedController < ApplicationController
  before_action :authenticate_user!, except: [:information]

  def information

  end

  def welcome

  end
end
