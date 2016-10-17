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
    date_monday = Date.new(2016, 12, 5)
    @date_list = { date_monday.strftime("%A the #{date_monday.day.ordinalize} of %B %Y") => "#{date_monday}" }
    render :layout => false
  end

  def update_registration
    rsvp = Rsvp.find_by_id(params[:rsvp_id])
    if rsvp.present?
      rsvp.preferred_date = params[:preferred_date]
      if rsvp.save
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

          date_friday = Date.new(2016, 12, 2)
          date_monday = Date.new(2016, 12, 5)
          date_either = Date.new(2010, 10, 10)
          @date_list = {date_friday.strftime("%A the #{date_friday.day.ordinalize} of %B %Y") => "#{date_friday}", date_monday.strftime("%A the #{date_monday.day.ordinalize} of %B %Y") => "#{date_monday}", "Either Day" => date_either}

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
    permitted = params.permit(:full_name, :email, :preferred_date)
    rsvp = Rsvp.new(permitted)

    if rsvp.save
      # Tell the user they've done it
      UserMailer.conference_registration("#{params[:full_name]} <#{params[:email]}>", rsvp).deliver_now
      notify_slack("Someone has registered for the Bridging the Gap Teacher Conference...", nil, rsvp.inspect, "A7B8C9")

      # And back we go
      redirect_to "/teacher_conference/registration?id=#{rsvp.id}&email=#{rsvp.email}", notice: "Your pre registration has been saved successfully."
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
