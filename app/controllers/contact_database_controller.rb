class ContactDatabaseController < ApplicationController
  before_action :require_administrator!
  
  def interface
  end
end
