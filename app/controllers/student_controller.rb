class StudentController < ApplicationController
  def index
  end
  def survey
    @isurvey = ISurvey.where(id: params[:id])
    if @isurvey.count >= 1
      @isurvey = @isurvey.first
      @iquestions = @isurvey.i_questions
    else
      redirect_to "/student", alert: "Sorry, that survey isn't available yet."
    end
  end
  def save
    redirect_to "/student", notice: "Thank you for participating."
  end
end
