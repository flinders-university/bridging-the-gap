class UnitPresentationsController < ApplicationController
  before_action :set_unit_presentation, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /unit_presentations
  # GET /unit_presentations.json
  def index
    @unit_presentations = UnitPresentation.all
  end

  # GET /unit_presentations/1
  # GET /unit_presentations/1.json
  def show
  end

  # GET /unit_presentations/new
  def new
    @unit_presentation = UnitPresentation.new
  end

  # GET /unit_presentations/1/edit
  def edit
  end

  # POST /unit_presentations
  # POST /unit_presentations.json
  def create
    @unit_presentation = UnitPresentation.new(unit_presentation_params)

    respond_to do |format|
      if @unit_presentation.save
        format.html { redirect_to @unit_presentation, notice: 'Unit presentation was successfully created.' }
        format.json { render :show, status: :created, location: @unit_presentation }
      else
        format.html { render :new }
        format.json { render json: @unit_presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_presentations/1
  # PATCH/PUT /unit_presentations/1.json
  def update
    respond_to do |format|
      if @unit_presentation.update(unit_presentation_params)
        format.html { redirect_to @unit_presentation, notice: 'Unit presentation was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit_presentation }
      else
        format.html { render :edit }
        format.json { render json: @unit_presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_presentations/1
  # DELETE /unit_presentations/1.json
  def destroy
    @unit_presentation.destroy
    respond_to do |format|
      format.html { redirect_to unit_presentations_url, notice: 'Unit presentation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_presentation
      @unit_presentation = UnitPresentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_presentation_params
      params.require(:unit_presentation).permit(:title, :user_id, :presentation, :notes)
    end
end
