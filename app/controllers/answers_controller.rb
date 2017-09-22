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
    if params[:option].present?

      @survey = ISurvey.find_by_id( params[:id] )
      @answer_set = {}

      @users = User.all.each do |usr|

      @answers = Answer.where(survey_id: @survey.id, user_id: usr.id).order(:question_id)

      @questions = IQuestion.where(i_survey_id: @survey.id).order(:order)

      ord = ""
      @questions.each do |qns|
        if ord != "" then
          ord = "#{ord}, #{qns.order}"
        else
          ord = "#{qns.order}"
        end
      end

      @qcount = @questions.count

      @answer_set["questions"] = ord

        if @answers.count >= 1 then
          the_answers = ""
          @answers.each do |ans|
            @iqs = IQuestion.where(i_survey_id: @survey.id, id: ans.question_id)

            if @iqs.count >= 1 then
              if the_answers != "" then
                the_answers = "#{the_answers}, #{ans.answer}"
              else
                the_answers = "#{ans.answer}"
              end
            else
              if the_answers != "" then
                the_answers = "#{the_answers}, 'MISSING'"
              else
                the_answers = "'MISSING'"
              end
            end
          end
          @answer_set[usr.id] = the_answers
        end
      end

      fnlset = ""
      @answer_set.each do |ask, asv|
        if @user = User.find_by_id(ask) then @un = @user.name else @un = "Undefined user" end
        if fnlset != ""
          fnlset = "#{fnlset}\n'#{ask} #{@un}',#{asv}"
        else
          fnlset = "#{ask}, '#{@un}',#{asv}"
        end
      end

      @answer_set = fnlset

      #raise @answer_set

      return @answer_set

    else
      false
    end
  end

  def to_csv(input)
    CSV.generate do |csv|
      input.each do |row|
        csv << row
      end
    end
  end
end
