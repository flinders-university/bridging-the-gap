class StudentGroupsController < ApplicationController
  before_action :set_student_group, only: [:show, :edit, :update, :destroy]
  before_action :require_administrator!, except: [:show]
  before_action :authenticate_user!

  # GET /student_groups
  # GET /student_groups.json
  def index
    @student_groups = StudentGroup.all
  end

  # GET /student_groups/1
  # GET /student_groups/1.json
  def show
    if current_user.group.level == 2
      if !@student_group.users.find_by_id(current_user)
        redirect_to root_url, notice: "Sorry, you're not a member of that group."
      end
    elsif current_user_administrator?
    else
      redirect_to root_url, notice: "Sorry, your account doesn't have access to that feature."
    end
  end

  # GET /student_groups/new
  def new
    @student_group = StudentGroup.new
  end

  # GET /student_groups/1/edit
  def edit
  end

  # POST /student_groups
  # POST /student_groups.json
  def create
    @student_group = StudentGroup.new(student_group_params)

    respond_to do |format|
      if @student_group.save
        format.html { redirect_to @student_group, notice: 'Student group was successfully created.' }
        format.json { render :show, status: :created, location: @student_group }
      else
        format.html { render :new }
        format.json { render json: @student_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_groups/1
  # PATCH/PUT /student_groups/1.json
  def update
    respond_to do |format|
      if @student_group.update(student_group_params)
        format.html { redirect_to @student_group, notice: 'Student group was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_group }
      else
        format.html { render :edit }
        format.json { render json: @student_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_groups/1
  # DELETE /student_groups/1.json
  def destroy
    @student_group.destroy
    respond_to do |format|
      format.html { redirect_to student_groups_url, notice: 'Student group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_group
      @student_group = StudentGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_group_params
      params.require(:student_group).permit(:confirmed, :finalised)
    end
end
