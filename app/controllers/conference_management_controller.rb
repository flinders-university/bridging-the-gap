class ConferenceManagementController < ApplicationController
  before_action :require_administrator!

  def name_badges
    @rsvps = Rsvp.all
    @stcs = Stc2016.all

    render layout: false
  end

  def sign_in_sheet
    @rsvps = Rsvp.all
    @stcs = Stc2016.all

    render layout: false
  end

  def export
    @rsvps = Rsvp.all.order(:created_at)
    @stcs = Stc2016.all

    respond_to do |format|
      format.html { render text: "No HTML export facility." }
      format.json { render json: "No JSON export facility.".to_json }
      format.csv { send_data @rsvps.to_csv, filename: "conference-rsvp-#{Date.today}.csv" }
    end
  end

  def index
    @rsvps = Rsvp.all.order(:full_name)
    @rsvp_count = @rsvps.count
  end

  def update
    rsvp = Rsvp.find_by_id(params[:rsvp_id])
    permitted = params.permit(:interested, :attended)
    if rsvp.update(permitted)
      redirect_to "/conference_management/index", alert: "Registration updated."
    else
      redirect_to "/conference_management/index", alert: "Registration could not be updated."
    end
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
