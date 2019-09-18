class FgBookingsController < ApplicationController
  before_action :set_fg_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_administrator!, except: [:new, :create, :edit, :update]

  before_action :rdt

  # GET /fg_bookings
  # GET /fg_bookings.json
  def index
    @fg_bookings = FgBooking.all
  end

  # GET /fg_bookings/1
  # GET /fg_bookings/1.json
  def show
  end

  # GET /fg_bookings/new
  def new
    @fg_booking = FgBooking.new
  end

  # GET /fg_bookings/1/edit
  def edit
  end

  # POST /fg_bookings
  # POST /fg_bookings.json
  def create
    @fg_booking = FgBooking.new(fg_booking_params)

    respond_to do |format|
      if @fg_booking.save
        UserMailer.focus_group_time(current_user, @fg_booking).deliver_now
        format.html { redirect_to getting_started_welcome_path, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @fg_booking }
      else
        format.html { render :new }
        format.json { render json: @fg_booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fg_bookings/1
  # PATCH/PUT /fg_bookings/1.json
  def update
    respond_to do |format|
      if @fg_booking.update(fg_booking_params)
        format.html { redirect_to getting_started_welcome_path, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @fg_booking }
      else
        format.html { render :edit }
        format.json { render json: @fg_booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fg_bookings/1
  # DELETE /fg_bookings/1.json
  def destroy
    @fg_booking.destroy
    respond_to do |format|
      format.html { redirect_to fg_bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fg_booking
      @fg_booking = FgBooking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fg_booking_params
      params.require(:fg_booking).permit(:user_id, :booking)
    end

    def rdt
      redirect_to root_url
    end
end
