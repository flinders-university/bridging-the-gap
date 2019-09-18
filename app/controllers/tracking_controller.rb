class TrackingController < ApplicationController
  before_action :require_administrator!

  def students
    # Import PSTs
    @Users = User.where(group_id: 4).order(:industry_id, :created_at)
  end
end
