class IlluminetController < ApplicationController
  before_action :require_administrator!, except: [:polymer, :take, :save]
  before_action :authenticate_user!
  before_action :set_group_membership

  def polymer
    if params[:survey] == "ee"
      flash[:notice] = "Thank you for attempting that survey. You can come back to any unanswered questions at any time below."
    else
      flash[:notice] = nil
    end
    @forms = Form.where(group_id: current_user.group.id)
    @isurveys = ISurvey.where(group_id: current_user.group.id).where(enabled: true)
    @at_least_one_signature = 0
    @forms.each do |form|
      form.signatures.each do |signature|
        if signature.user == current_user
          @at_least_one_signature = @at_least_one_signature + 1
        end
      end
    end
    @answers = Answer.where(:user_id => current_user.id)
  end

  def take
    @isurvey = ISurvey.where(group_id: current_user.group.id).where(id: params[:id])
    if @isurvey.count >= 1
      @isurvey = @isurvey.first
      @iquestions = @isurvey.i_questions
    else
      redirect_to illuminet_polymer_path, alert: "Sorry, that survey isn't available yet."
    end
  end

  def save
    redirect_to illuminet_polymer_path, notice: "Thank you for completing #{params[:name]}"
  end

  private
  def set_group_membership
    if current_user.group.level >= 2
    else
      redirect_to edit_user_registration_path, notice: "Please request access to the relevant group."
    end
  end
end
