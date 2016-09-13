class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :authenticate_user!

  before_action :require_administrator!, except: [:update, :check]

  def index
    @answers = Answer.all
    @surveys = ISurvey.all
    #Empty dict to fill with precache (to prevent mass queries)
    @users = {}
  end

  # GET /answers/1 (where 1 is survey id)
  def show
    @answers = Answer.where(survey_id: params[:id])
    @survey = ISurvey.find_by_id(params[:id])
    #Empty dict to fill with precache (to prevent mass queries)
    @users = {}
  end

  # GET /answers/export/1.csv
  # where [id] is Survey's ID
  def export
    @survey = ISurvey.find_by_id(params[:id])
    if @survey.present?
      respond_to do |format|
        format.text {
          result = prepareData(params)
          render text: to_csv(result)
        }
        format.csv {
          result = prepareData(params)
          render text: to_csv(result)
        }
        format.json {
          result = prepareData(params)
          render json: result
        }
        format.html {

        }
      end
    else
      redirect_to answers_path, notice: "Couldn't find the survey for that ID."
    end
  end

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
            qdes = "Orphaned question"
          end

          s = ISurvey.find_by_id(params[:survey_id])

          if s.present?
            sdes = s.title
          else
            sdes = "Orphaned survey"
          end
          #sendCable("#{current_user.name} &lt;#{current_user.email}&gt;", "[#{sdes}] #{qdes}:", params[:answer])

          render json:{"continue" => true}
        else
          render json:{"continue" => false}
        end
      end
      if !@created && answer
        answer.answer = params[:answer]
        if answer.save
          #sendCable("#{current_user.name} &lt;#{current_user.email}&gt;", "Updated Answer: ", params[:answer])
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

  def prepareData(params)
    if params[:option].present?
      @survey = ISurvey.find_by_id( params[:id] )

      @answers = Answer.where(survey_id: @survey.id)

      # Answers, without user data
      @answers_noud = {}
      # Answers, with user data
      @answers_ud = {}

      # For each answer, build a row for return
      @answers.each do |answer|
        question = IQuestion.find_by_id(answer.question_id)
        user = answer.user
        group = answer.group

        if @answers_ud[user.id].present?
          @answers_ud[user.id]["[CODE: #{question.grouping_value}] #{question.order}. #{question.description}"] = answer.answer
          @answers_noud[user.id]["[CODE: #{question.grouping_value}] #{question.order}. #{question.description}"] = answer.answer
        else
          @answers_ud[user.id] = {
            "First Name" => user.firstname,
            "Last Name" => user.lastname,
            "Group" => group.name,
            "Survey Name" => question.i_survey.title,
            "Survey ID" => question.i_survey.id,
            "[CODE: #{question.grouping_value}] #{question.order}. #{question.description}" => answer.answer
          }
          @answers_noud[user.id] = {
            "Survey Name" => question.i_survey.title,
            "Survey ID" => question.i_survey.id,
            "[CODE: #{question.grouping_value}] #{question.order}. #{question.description}" => answer.answer
          }
        end

      end

      if params[:option] == "ud"
        # Request for Rendered User Data
        return @answers_ud
      elsif params[:option] == "nd"
        # Request for data without user information
        return @answers_noud
      end
    else
      false
    end
  end

  def to_csv(input)
    CSV.generate do |csv|
      i = 0;
      input.each do |row|
        i =+ 1
        if i <= 1
          csv << row[1].keys
          csv << row[1].values
        else
          csv << row[1].values
        end
      end
    end
  end
end
