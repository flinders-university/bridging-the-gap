class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  before_action :require_administrator!, except: [:show]

  # GET /forms
  # GET /forms.json
  def index
    @forms = Form.all
    @groups = Group.all
  end

  # GET /forms/1
  # GET /forms/1.json
  def show
  end

  # GET /forms/signature_tree/1
  def signature_tree
    @form = Form.find_by_id(params[:form_id])

    if !@form.present?
      redirect_to forms_path, alert: "Please select a form first"
    end
    render :layout => false
  end

  # GET /forms/new
  def new
    @form = Form.new
    @groups = Group.all
  end

  # GET /forms/1/edit
  def edit
    @groups = Group.all
  end

  # POST /forms
  # POST /forms.json
  def create
    @form = Form.new(form_params)
    @groups = Group.all

    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: 'Form was successfully created.' }
        format.json { render :show, status: :created, location: @form }
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1
  # PATCH/PUT /forms/1.json
  def update
    @groups = Group.all
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to @form, notice: 'Form was successfully updated.' }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.json
  def destroy
    @form.destroy
    respond_to do |format|
      format.html { redirect_to forms_url, notice: 'Form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:title, :group_id, :description, :body, :date_required)
    end
end
