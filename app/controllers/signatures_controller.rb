class SignaturesController < ApplicationController
  before_action :set_signature, only: [:show, :edit, :update, :destroy]

  before_action :require_administrator!, except: [:new, :create]

  # GET /signatures
  # GET /signatures.json
  def index
    @signatures = Signature.all
  end

  # GET /signatures/1
  # GET /signatures/1.json
  def show
    render :layout => false
  end

  # GET /signatures/new
  def new
    @signature = Signature.new
    @signature.user = current_user

    @forms = Form.where(group: current_user.group)
  end

  # GET /signatures/1/edit
  def edit
  end

  # POST /signatures
  # POST /signatures.json
  def create
    @signature = Signature.new(signature_params)
    @signature.user = current_user
    @forms = Form.where(group: current_user.group)

    respond_to do |format|
      if @signature.save
        format.html { redirect_to illuminet_polymer_path, notice: 'Consent form was successfully signed.' }
        format.json { render :show, status: :created, location: @signature }
      else
        format.html { render :new }
        format.json { render json: @signature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /signatures/1
  # PATCH/PUT /signatures/1.json
  def update
    respond_to do |format|
      if @signature.update(signature_params)
        format.html { redirect_to @signature, notice: 'Signature was successfully updated.' }
        format.json { render :show, status: :ok, location: @signature }
      else
        format.html { render :edit }
        format.json { render json: @signature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signatures/1
  # DELETE /signatures/1.json
  def destroy
    @signature.destroy
    respond_to do |format|
      format.html { redirect_to forms_path, notice: 'Signature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signature
      @signature = Signature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def signature_params
      params.require(:signature).permit(:user_id, :form_id, :data)
    end
end
