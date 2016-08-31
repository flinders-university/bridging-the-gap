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

  def addplacement
    u = User.find_by_email(params[:email])
    if u.setplacement(params[:industry_id])
      redirect_to industries_path, notice: "Added placement data"
    else
      redirect_to industries_path, notice: "Could not add placement data..."
    end
  end

  def disassociate_placement
    u = User.find_by_email(params[:email])
    if u.setplacement(nil)
      redirect_to usertools_path, notice: "Disassociated placement details."
    else
      redirect_to usertools_path, notice: "Could not disassociate placement details."
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to usertools_path, notice: "User deleted."
    else
      redirect_to usertools_path, notice: "Could not delete that user."
    end
  end

  def new

  end

  def create
    if params[:firstname].length >= 1 && params[:lastname].length >= 1 && params[:email].length >= 1 && params[:password].length >= 6
      u = User.new
      u.firstname = params[:firstname]
      u.lastname = params[:lastname]
      u.email = params[:email]
      u.password = params[:password]
      u.group_id = params[:group_id]
      u.administrator = params[:administrator]
      if params[:industry_id]
        u.industry_id = params[:industry_id]
      end
      if u.save
        redirect_to "/usertools/" + u.id.to_s, notice: "User created successfully"
      end
    else
      redirect_to usertools_new_path, notice: "Could not save that user, required details were missing."
    end
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
            u.degree = imported_user["degree"]
            u.major = imported_user["major"]
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
    @User.group_id = params[:group_id]
    @User.student_group_id = params[:student_group_id]
    @User.administrator = params[:administrator]
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
