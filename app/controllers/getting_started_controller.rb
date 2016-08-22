class GettingStartedController < ApplicationController
  before_action :authenticate_user!, except: [:information]

  def information
    if current_user.present?
      redirect_to getting_started_welcome_path
    end
  end

  def welcome
    if current_user.group.level == 4
      @Tasks = Task.where(user_id: current_user.id, visible: true).order(:when)
    end
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

end
