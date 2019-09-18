class ResearchScientistsController < ApplicationController
  before_action :set_research_scientist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_administrator!, except: [:show]

  # GET /research_scientists
  # GET /research_scientists.json
  def index
    @research_scientists = ResearchScientist.all
  end

  # GET /research_scientists/1
  # GET /research_scientists/1.json
  def show
    if current_user.group.level == 2
      if @research_scientist.student_group_id != current_user.student_group_id
        redirect_to root_url, notice: "Sorry, your group has not been assigned to that research scientist."
      end
    elsif current_user.group.level == 6
      if @research_scientist.user_id != current_user.id
        redirect_to root_url, notice: "Sorry, you're not that research scientist."
      end
    elsif current_user_administrator?
    else
      redirect_to root_url, notice: "Sorry, your account doesn't have access to that feature."
    end
  end

  # GET /research_scientists/new
  def new
    @research_scientist = ResearchScientist.new
  end

  # GET /research_scientists/1/edit
  def edit
  end

  # POST /research_scientists
  # POST /research_scientists.json
  def create
    @research_scientist = ResearchScientist.new(research_scientist_params)

    respond_to do |format|
      if @research_scientist.save
        format.html { redirect_to @research_scientist, notice: 'Research scientist was successfully created.' }
        format.json { render :show, status: :created, location: @research_scientist }
      else
        format.html { render :new }
        format.json { render json: @research_scientist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /research_scientists/1
  # PATCH/PUT /research_scientists/1.json
  def update
    respond_to do |format|
      if @research_scientist.update(research_scientist_params)
        format.html { redirect_to @research_scientist, notice: 'Research scientist was successfully updated.' }
        format.json { render :show, status: :ok, location: @research_scientist }
      else
        format.html { render :edit }
        format.json { render json: @research_scientist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /research_scientists/1
  # DELETE /research_scientists/1.json
  def destroy
    @research_scientist.destroy
    respond_to do |format|
      format.html { redirect_to research_scientists_url, notice: 'Research scientist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_research_scientist
      @research_scientist = ResearchScientist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def research_scientist_params
      params.require(:research_scientist).permit(:student_group_id, :user_id, :public_email, :public_phone, :public_bio, :enabled)
    end
end
