class GroupChangeRequestsController < ApplicationController
  before_action :set_group_change_request, only: [:show, :edit, :update, :destroy]

  before_action :require_administrator!, except: [:create]

  # GET /group_change_requests
  # GET /group_change_requests.json
  def index
    @group_change_requests = GroupChangeRequest.all
  end

  def show
    u = User.find_by_id(@group_change_request.user_id)
    g = Group.find_by_id(@group_change_request.group_id)
    if (u.present? && g.present?)
      u.group = g
      if u.save
        @group_change_request.destroy
        redirect_to group_change_requests_path, notice: "Change processed"
      else
        redirect_to group_change_requests_path, notice: "Could not process group change"
      end
    else
      redirect_to group_change_requests_path, notice: "Could not process group change"
    end
  end

  # POST /group_change_requests
  # POST /group_change_requests.json
  def create
    @group_change_request = GroupChangeRequest.new

    @group_change_request.group_id = params[:group_id]
    @group_change_request.user_id = params[:user_id]

    if @group_change_request.save
      redirect_to edit_user_registration_path, notice: 'Group change request was successfully created.'
    else
      redirect_to edit_user_registration_path, notice: 'Could not process your group change request.'
    end
  end

  # DELETE /group_change_requests/1
  # DELETE /group_change_requests/1.json
  def destroy
    @group_change_request.destroy
    respond_to do |format|
      format.html { redirect_to group_change_requests_url, notice: 'Group change request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_change_request
      @group_change_request = GroupChangeRequest.find(params[:id])
    end
end
