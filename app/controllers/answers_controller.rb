class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :authenticate_user!

  # POST /answers/update.json
  # First or creates answer.
  def update
    # Using first or create allows users to update their answer (or create it obviously)
    answer = Answer.where(:question_id => params[:question_id], :user_id => current_user.id).first_or_create! do |answer|
      answer.user_id = current_user.id
      answer.survey_id = params[:survey_id]
      answer.group_id = current_user.group.id
      answer.question_id = params[:question_id]
      answer.answer = params[:answer]

      @created = true

        if answer.save
          q = IQuestion.find_by_id(params[:question_id])

          if q.present?
            qdes = q.description
          else
            qdes = "Missing question"
          end

          s = ISurvey.find_by_id(params[:survey_id])

          if s.present?
            sdes = s.title
          else
            sdes = "Missing survey"
          end
          sendCable("#{current_user.name} &lt;#{current_user.email}&gt;", "[#{sdes}] #{qdes}:", params[:answer])

          render json:{"continue" => true}
        else
          render json:{"continue" => false}
        end
      end
      if !@created && answer
        answer.answer = params[:answer]
        if answer.save
          sendCable("#{current_user.name} &lt;#{current_user.email}&gt;", "Updated Answer: ", params[:answer])
          render json:{"continue" => true}
        else
          render json:{"continue" => false}
        end
      end
  end

  # GET /answers/check.json?question_id=x
  def check
    @answers = Answer.where(:question_id => params[:question_id], :user_id => current_user.id)
    if @answers.count <= 0
      render json:{"continue" => true}
    else
      render json:{"continue" => false}
    end
  end

  private
  def sendCable(name, message, answer)
    ActionCable.server.broadcast 'answers', user: "#{name}", message: "#{message}", answer: "#{answer}"
  end
end
