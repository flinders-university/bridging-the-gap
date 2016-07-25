class UsertoolsController < ApplicationController
  def search
    if request.post?
      @users = User.where("email LIKE ?", "%#{params[:email]}%")
      if !@users
        @users = User.where("lastname LIKE ?", "%#{params[:lastname]}%")
      end
    end
    render :layout => false
  end

  def new
  end

  def create
  end

  def update
  end

  def manage
  end
end
