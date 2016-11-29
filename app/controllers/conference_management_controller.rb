class ConferenceManagementController < ApplicationController
  before_action :require_administrator!

  def name_badges
    @rsvps = Rsvp.all
    @stcs = Stc2016.all

    render layout: false
  end

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

  def pst
    @stcs = Stc2016.all
    @stc_count = @stcs.count
  end

  def destroy_pst
    rsvp = Stc2016.find_by_id(params[:stc_id])
    if rsvp.present? && rsvp.destroy
      redirect_to "/conference_management/pst", notice: "Registration removed successfully."
    else
      redirect_to "/conference_management/pst", alert: "Registration could not be removed."
    end
  end
end
