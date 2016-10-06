class ConferenceManagementController < ApplicationController
  before_action :require_administrator!

  def index
    @rsvps = Rsvp.all
    @rsvp_count = @rsvps.count
  end

  def destroy
    rsvp = Rsvp.find_by_id(params[:rsvp_id])
    if rsvp.present? && rsvp.destroy
      redirect_to "/conference_management/index", notice: "Registration removed successfully."
    else
      redirect_to "/conference_management/index", alert: "Registration could not be removed."
    end
  end
end
