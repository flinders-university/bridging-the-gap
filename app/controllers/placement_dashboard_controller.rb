class PlacementDashboardController < ApplicationController
  before_action :authenticate_user!

  def preservice_teacher
    if current_user.group.level != 2
      raise "Expected #{Group.where(level: 2).last.name}, got #{current_user.group.name}."
    end
  end

  def industry
    if current_user.group.level != 3
      raise "Expected #{Group.where(level: 2).last.name}, got #{current_user.group.name}."
    end
    @industry = Industry.where(user_id: current_user.id).last
  end
end
