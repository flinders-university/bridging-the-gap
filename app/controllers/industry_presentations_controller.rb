class IndustryPresentationsController < ApplicationController
  before_action :set_industry_presentation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /industry_presentations
  # GET /industry_presentations.json
  def index
    if current_user.group.level == 4
      @industry_presentations = IndustryPresentation.all
    elsif current_user.group.level == 2
      @industry_presentations = IndustryPresentation.where(user_id: current_user.id)
    else
      if current_user.industry.present?
        @industry_presentations = IndustryPresentation.where(industry_id: current_user.industry)
      else
        redirect_to root_url, notice: "Sorry, your account doesn't have access to this feature"
      end
    end
  end

  # GET /industry_presentations/1
  # GET /industry_presentations/1.json
  def show
  end

  # GET /industry_presentations/new
  def new
    @industry_presentation = IndustryPresentation.new
  end

  # GET /industry_presentations/1/edit
  def edit
  end

  # POST /industry_presentations
  # POST /industry_presentations.json
  def create
    @industry_presentation = IndustryPresentation.new(industry_presentation_params)

    @industry_presentation.user_id = current_user.id

    respond_to do |format|
      if @industry_presentation.save
        format.html { redirect_to @industry_presentation, notice: 'Industry presentation was successfully created.' }
        format.json { render :show, status: :created, location: @industry_presentation }
      else
        format.html { render :new }
        format.json { render json: @industry_presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /industry_presentations/1
  # PATCH/PUT /industry_presentations/1.json
  def update
    respond_to do |format|
      if @industry_presentation.update(industry_presentation_params)
        format.html { redirect_to @industry_presentation, notice: 'Industry presentation was successfully updated.' }
        format.json { render :show, status: :ok, location: @industry_presentation }
      else
        format.html { render :edit }
        format.json { render json: @industry_presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /industry_presentations/1
  # DELETE /industry_presentations/1.json
  def destroy
    @industry_presentation.destroy
    respond_to do |format|
      format.html { redirect_to industry_presentations_url, notice: 'Industry presentation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_industry_presentation
      @industry_presentation = IndustryPresentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def industry_presentation_params
      params.require(:industry_presentation).permit(:user_id, :industry_id, :title, :description, :presentation, :script)
    end
end
