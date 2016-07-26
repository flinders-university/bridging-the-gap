class IQuestionsController < ApplicationController
  before_action :set_i_question, only: [:show, :edit, :update, :destroy]

  # GET /i_questions
  # GET /i_questions.json
  def index
    @i_questions = IQuestion.all
    @i_surveys = ISurvey.all
  end

  # GET /i_questions/1
  # GET /i_questions/1.json
  def show
  end

  # GET /i_questions/new
  def new
    @i_question = IQuestion.new
  end

  # GET /i_questions/1/edit
  def edit
  end

  # POST /i_questions
  # POST /i_questions.json
  def create
    @i_question = IQuestion.new(i_question_params)

    respond_to do |format|
      if @i_question.save
        format.html { redirect_to @i_question, notice: 'I question was successfully created.' }
        format.json { render :show, status: :created, location: @i_question }
      else
        format.html { render :new }
        format.json { render json: @i_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /i_questions/1
  # PATCH/PUT /i_questions/1.json
  def update
    respond_to do |format|
      if @i_question.update(i_question_params)
        format.html { redirect_to @i_question, notice: 'I question was successfully updated.' }
        format.json { render :show, status: :ok, location: @i_question }
      else
        format.html { render :edit }
        format.json { render json: @i_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /i_questions/1
  # DELETE /i_questions/1.json
  def destroy
    @i_question.destroy
    respond_to do |format|
      format.html { redirect_to i_questions_url, notice: 'I question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_i_question
      @i_question = IQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def i_question_params
      params.require(:i_question).permit(:i_survey_id, :input_type, :description, :grouping_value, :enabled, :comment)
    end
end
