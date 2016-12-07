class GettingStartedController < ApplicationController
  before_action :authenticate_user!, except: [:information, :teacher_conference, :tc_register, :view_registration, :update_registration]

  def information
    if current_user.present? && !params[:noredirect] == true
      if notice
        redirect_to getting_started_welcome_path, notice: "#{notice}"
      elsif alert
        redirect_to getting_started_welcome_path, alert: "#{alert}"
      else
        redirect_to getting_started_welcome_path
      end
    end
  end

  def welcome
    @Tasks = Task.where(user_id: current_user.id, visible: true).order(:when)
    flash[:notice] = nil
  end

  def mark_task_complete
    @Task = Task.find_by_id(params[:task_id])
    if @Task.user == current_user
      @Task.completed = true
      if @Task.save
        redirect_to getting_started_welcome_path, notice: "Thank you, your task has been marked as complete."
      else
        redirect_to getting_started_welcome_path, notice: "Sorry, this task cannot be completed by you, it is dependent on others."
      end
    else
      redirect_to getting_started_welcome_path, notice: "Sorry, this task cannot be completed by you, it is dependent on others."
    end
  end

  def teacher_conference
    @rsvp = Rsvp.new
    render :layout => false
  end

  def mod_interest
    rsvp = Rsvp.find_by_id(params[:rsvp_id])
    if rsvp.present?
      permitted = params.permit(:interested)
      if rsvp.update(permitted)
        redirect_to "/teacher_conference/registration?id=#{rsvp.id}&email=#{rsvp.email}", notice: "Your details were updated successfully."
      else
        redirect_to "/teacher_conference/registration?id=#{rsvp.id}&email=#{rsvp.email}", alert: "Sorry, your details could not be updated. Please try again."
      end
    else
      redirect_to "/teacher_conference", notice: "Could not find a record of that registration."
    end
  end

  def update_registration
    rsvp = Rsvp.find_by_id(params[:rsvp_id])

    if rsvp.present?
      permitted = params.permit(:full_name, :email, :role, :school, :year_level, :for_full_name, :for_email, :attending_too)
      if rsvp.update(permitted)
        redirect_to "/teacher_conference/registration?id=#{rsvp.id}&email=#{rsvp.email}", notice: "Your registration was updated successfully."
      else
        redirect_to "/teacher_conference/registration?id=#{rsvp.id}&email=#{rsvp.email}", alert: "Sorry, your registration could not be updated. Please try again."
      end
    else
      redirect_to "/teacher_conference", notice: "Could not find a record of that registration."
    end
  end

  def view_registration
    if params[:id].present? && params[:email].present?
      if rsvp = Rsvp.find_by_email(params[:email])
        if rsvp.id == params[:id].to_i
          @rsvp = rsvp

          render :layout => false
        else
          redirect_to "/teacher_conference", notice: "Could not find a record of that registration."
        end
      else
        redirect_to "/teacher_conference", notice: "Could not find a record of that registration."
      end
    else
      redirect_to "/teacher_conference", notice: "Could not find a record of that registration."
    end
  end

  def tc_register
    # do something with the Rsvp model
    permitted = params.permit(:full_name, :email, :role, :school, :year_level, :for_full_name, :for_email, :attending_too)
    rsvp = Rsvp.new(permitted)

    if rsvp.save
      # Tell the user they've done it
      UserMailer.conference_registration("#{params[:full_name]} <#{params[:email]}>", rsvp).deliver_now
      notify_slack("Someone has registered for the Bridging the Gap Teacher Conference...", nil, rsvp.inspect, "A7B8C9")

      # And back we go
      redirect_to "/teacher_conference/registration?id=#{rsvp.id}&email=#{rsvp.email}", notice: "Your registration has been saved successfully."
    else
      if (frsvp = Rsvp.find_by_email(params[:email])) && (rsvp.present?)
        redirect_to "/teacher_conference/registration?id=#{frsvp.id}&email=#{frsvp.email}", notice: "You have already registered for the conference. Update your registration below."
      else
        # Oops...
        errors = "<br>"
        rsvp.errors.full_messages.each do |error|
          errors = errors + "&bull; #{error}. "
        end
        redirect_to "/teacher_conference", alert: "Your pre registration could not be saved. Please try again. #{errors}"
      end
    end
  end

end
