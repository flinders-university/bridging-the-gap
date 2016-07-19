class GroupsController < ApplicationController
  before_action :require_administrator!

  before_action :set_group, except: [:index, :create]

  def index
    @groups = Group.all
  end

  def show
  end

  def add_user
    @user = User.find_by_email(params[:contact])
    if @user
      @user.group_id = @group.id
      if @user.save
        redirect_to group_path(@group.level), notice: "User added to group"
      else
        redirect_to group_path(@group.level), notice: "User could not be saved"
      end
    else
      redirect_to group_path(@group.level), notice: "User could not be found"
    end
  end

  def update
  end

  def create
    #Static allocation of types instead of params permitted
    @group = Group.new
    @group.level = params[:level]
    @group.name = params[:name]
    @group.contact = params[:contact]
    @group.description = params[:description]

    if @group.save
      redirect_to group_path(@group.level), notice: "Group created successfully"
    else
      redirect_to groups_path, notice: "Could not create that group"
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_path, notice: "Group destroyed successfully"
    else
      redirect_to groups_path, notice: "Group could not be destroyed"
    end
  end

  private
  def set_group
    @group = Group.find_by_level(params[:group_id] || params[:id])
    if !@group
      redirect_to groups_path, notice: "Couldn't find that group"
    end
  end
end
