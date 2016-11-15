class CelebrationController < ApplicationController
  # 2016 Celebration
  def indexsixteen
    @stc2016 ||= Stc2016.new
  end

  def save
    @stc2016 = Stc2016.new(stc_params)
    if @stc2016.save
      UserMailer.pst_celebration_sixteen(@stc2016.email, @stc2016)
      render json: true
    else
      render json: false
    end
  end

  private
  def stc_params
    params.permit(:name, :degreeyear, :email, :plusone, :plusone_name)
  end
end
