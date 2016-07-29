class UsertoolsController < ApplicationController
  before_action :require_administrator!

  # GET /usertools/search
  # POST /usertools/search
  def search
    if request.post?
      @users = User.where("email LIKE ?", "%#{params[:email]}%")
      if !@users
        @users = User.where("lastname LIKE ?", "%#{params[:lastname]}%")
      end
    end
    render :layout => false
  end

  def import

  end

  def importer
    content = params[:import].read
    import = JSON.parse content
    if import
      i = 0
      s = 0
      e = 0
      import.each do |imported_user|
        if User.find_by_email(imported_user["email"])
          e = e + 1
        else
          i = i + 1
          u = User.new
          u.firstname = imported_user["firstname"]
          u.lastname = imported_user["lastname"]
          u.email = imported_user["email"]
          u.administrator = false
          if imported_user["degree"].present?
            u.group = Group.find_by_level(2)
            u.password = imported_user["student_id"]
          elsif imported_user["job_title"].present?
            u.group = Group.find_by_level(3)
            u.password = "industrycontact123"
          else
            u.group = Group.find_by_level(1)
            u.password = "generalcontact123"
          end
          if u.save
            s = s + 1
          end
        end
      end
      redirect_to usertools_path, notice: "#{s}/#{i} users were imported. #{e} already existed."
    else
      redirect_to usertools_path, notice: "The structure of your upload is invalid."
    end
  end

  def edit
    @User = User.find_by_id(params[:id])
  end

  def update
    @User = User.find_by_id(params[:id])
    @User.firstname = params[:firstname]
    @User.lastname = params[:lastname]
    @User.email = params[:email]
    if @User.save
      redirect_to usertools_path, notice: "User updated successfully."
    else
      redirect_to usertools_edit_path(params[:id]), notice: "Errors prevented this user from being saved."
    end
  end

  # GET /usertools/
  def manage
    @Users = User.all
  end
end
