class FocusGroupsController < ApplicationController
  before_action :set_focus_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_administrator!, except: [:index, :register]

  # GET /focus_groups
  # GET /focus_groups.json
  def index
    @focus_groups = FocusGroup.all
  end

  # GET /focus_groups/1
  # GET /focus_groups/1.json
  def show
  end

  # GET /focus_groups/new
  def new
    @focus_group = FocusGroup.new
  end

  # GET /focus_groups/1/edit
  def edit
  end

  # POST /focus_groups
  # POST /focus_groups.json
  def create
    @focus_group = FocusGroup.new(focus_group_params)

    respond_to do |format|
      if @focus_group.save
        format.html { redirect_to @focus_group, notice: 'Focus group was successfully created.' }
        format.json { render :show, status: :created, location: @focus_group }
      else
        format.html { render :new }
        format.json { render json: @focus_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /focus_groups/1
  # PATCH/PUT /focus_groups/1.json
  def update
    respond_to do |format|
      if @focus_group.update(focus_group_params)
        format.html { redirect_to @focus_group, notice: 'Focus group was successfully updated.' }
        format.json { render :show, status: :ok, location: @focus_group }
      else
        format.html { render :edit }
        format.json { render json: @focus_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /focus_groups/1
  # DELETE /focus_groups/1.json
  def destroy
    @focus_group.destroy
    respond_to do |format|
      format.html { redirect_to focus_groups_url, notice: 'Focus group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /focus_groups/1/register
  def register
    @focus_group = FocusGroup.find(params[:focus_group_id])

    if @focus_group.users.count >= @focus_group.slots
      redirect_to focus_groups_path, notice: "Sorry, that focus group is full"
    else
      current_user.focus_group_id = @focus_group.id
      current_user.save
      UserMailer.focus_group_time(current_user, @focus_group).deliver_now
      redirect_to focus_groups_path, notice: "You have successfully registered for that focus group time"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_focus_group
      @focus_group = FocusGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def focus_group_params
      params.require(:focus_group).permit(:name, :user_id, :start, :slots)
    end
end
