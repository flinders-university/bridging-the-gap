class IndustriesController < ApplicationController
  before_action :set_industry, only: [:show, :edit, :update, :destroy]
  before_action :admin_or_authorised

  # GET /industries
  # GET /industries.json
  def index
    if params[:engaged] == "true"
      @industries = Industry.where(active: true).order(:name)
    else
      @industries = Industry.all.order(:name)
    end
  end

  # GET /industries/1
  # GET /industries/1.json
  def show
  end

  # GET /industries/new
  def new
    @industry = Industry.new
  end

  # GET /industries/1/edit
  def edit
  end

  # POST /industries
  # POST /industries.json
  def create
    @industry = Industry.new(industry_params)

    respond_to do |format|
      if @industry.save
        format.html { redirect_to @industry, notice: 'Industry was successfully created.' }
        format.json { render :show, status: :created, location: @industry }
      else
        format.html { render :new }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /industries/1
  # PATCH/PUT /industries/1.json
  def update
    respond_to do |format|
      if @industry.update(industry_params)
        format.html { redirect_to @industry, notice: 'Industry was successfully updated.' }
        format.json { render :show, status: :ok, location: @industry }
      else
        format.html { render :edit }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /industries/1
  # DELETE /industries/1.json
  def destroy
    @industry.destroy
    respond_to do |format|
      format.html { redirect_to industries_url, notice: 'Industry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def admin_or_authorised
      if !current_user
        redirect_to new_user_session_path, notice: "Please log in first..."
      else
        if current_user.group.level != 4
          if !current_user_administrator?
            redirect_to root_url, notice: "Sorry, your account doesn't have access to that feature."
          end
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_industry
      @industry = Industry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def industry_params
      params.require(:industry).permit(:user_id, :name, :address, :phone, :email, :website, :stem_foci, :description, :blurb, :active, :show_info)
    end
end
