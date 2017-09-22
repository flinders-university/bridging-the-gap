class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :authenticate_user!, except: [:update, :check]

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

  def htmlreport
    @answers = Answer.all
    @surveys = ISurvey.where(id: params[:id])
    #Empty dict to fill with precache (to prevent mass queries)
    @users = {}

    #populate the user information
    @surveys.last.i_questions.order(:order).each do |question|
      @answers.where(:survey_id => @surveys.last.id, :question_id => question.id).each do |answer|
        @users[answer.user_id] ||= User.find_by_id(answer.user_id)
      end
    end

    render layout: false
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
          render text: result
        }
        format.zip {
          require 'zip'

          compressed_filestream = Zip::OutputStream.write_buffer(::StringIO.new('')) do |zos|
            zos.put_next_entry "data-set-#{params[:id]}.csv"
            result = prepareData(params)
            csv = to_csv(result)
            zos.print csv

            zos.put_next_entry "import_command.sps"
            zos.print File.read(Rails.root.join("spss/import_command.sps"))

            zos.put_next_entry "student_pre_format.tpf"
            zos.print File.read(Rails.root.join("spss/student_pre_format.tpf"))
          end

          compressed_filestream.rewind
          send_data compressed_filestream.read, filename: "SPSS-Archive-#{Time.now.strftime("%-d_%-m_%y-%P")}.zip"
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

    # empty variables...
    @resulting_set = ""

    # get the survey from the params fed in to function
    @survey = ISurvey.find_by_id( params[:id] )

    @answers = Answer.where(survey_id: @survey.id).order(:user_id, :question_id)

    @last_user_id = 0

    @questions = IQuestion.where(i_survey_id: @survey.id).order(:order)

    @qns_str = ""
    @questions.each do |qns|
      if @qns_str != ""
        @qns_str = "#{@qns_str}, '#{qns.order} #{qns.description}'"
      else
        @qns_str = "#{qns.order} #{qns.description}"
      end
    end
    @resulting_set = "Name, blank, " + @qns_str

    @users_last_answer_questions_id = 0

    @answers.each do |an|
      @question = IQuestion.find(an.question_id)


      if @last_user_id != an.user_id
        @resulting_set = "#{@resulting_set}\n #{User.find(an.user_id).name}"
      end
      @last_user_id = an.user_id

      if @resulting_set != ""
        if (@users_last_answer_questions_id+1) == @question.order then
          @resulting_set = "#{@resulting_set}, (#{@question.order}) #{an.answer}"
        else
          @resulting_set = "#{@resulting_set}, , (#{@question.order}) #{an.answer}"
        end
      else
        @resulting_set = "#{@question.order | an.answer}"
      end

      @users_last_answer_questions_id = @question.order
    end

    raise @resulting_set
    #return @resulting_set
  end

  def to_csv(input)
    CSV.generate do |csv|
      input.each do |row|
        csv << row
      end
    end
  end
end
