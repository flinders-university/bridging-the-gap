class ISurveysController < ApplicationController
  before_action :set_i_survey, only: [:show, :edit, :update, :destroy]

  # GET /i_surveys
  # GET /i_surveys.json
  def index
    @i_surveys = ISurvey.all
    @groups = Group.all
  end

  # GET /i_surveys/1
  # GET /i_surveys/1.json
  def show
  end

  # GET /i_surveys/new
  def new
    @i_survey = ISurvey.new
  end

  # GET /i_surveys/1/edit
  def edit
  end

  # POST /i_surveys
  # POST /i_surveys.json
  def create
    @i_survey = ISurvey.new(i_survey_params)

    respond_to do |format|
      if @i_survey.save
        format.html { redirect_to @i_survey, notice: 'I survey was successfully created.' }
        format.json { render :show, status: :created, location: @i_survey }
      else
        format.html { render :new }
        format.json { render json: @i_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /i_surveys/1
  # PATCH/PUT /i_surveys/1.json
  def update
    respond_to do |format|
      if @i_survey.update(i_survey_params)
        format.html { redirect_to @i_survey, notice: 'I survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @i_survey }
      else
        format.html { render :edit }
        format.json { render json: @i_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /i_surveys/1
  # DELETE /i_surveys/1.json
  def destroy
    @i_survey.destroy
    respond_to do |format|
      format.html { redirect_to i_surveys_url, notice: 'I survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_i_survey
      @i_survey = ISurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def i_survey_params
      params.require(:i_survey).permit(:title, :description, :group_id, :form_id, :coding_explanation, :enabled)
    end
end
