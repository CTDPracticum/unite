class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_membership, only: %i[ show edit update destroy ]
  skip_before_action :authorized, only: [:new, :create]
  before_filter :authenticate_user!

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1 or /memberships/1.json
  def show    
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  # def create
  #  @membership = Membership.new(membership_params)
  #   if @membership.save
  #     session[:membership_id] = @membership.id
  #     redirect_to @membership
  #  else
  #     flash.now.alert = @membership.errors.full_messages.to_sentence
  #     render :new
  #   end
  # end
  def create
    @membership = current_user.memberships.build(:group_id => params[:group_id])
    if @membership.save
      flash.notice = "You have succesfully joined this group."
      redirect_to @membership
    else
      flash.error = "Unable to join."
      render :new
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
      if @membership.update(membership_params)
        flash.notice = "The membership record was updated successfully."
        redirect_to @membership
      else
        flash.now.alert = @membership.errors.full_messages.to_sentence
        render :edit
      end
  end

  # DELETE /memberships/1 or /memberships/1.json
  # def destroy
  #   @membership.destroy
  #   respond_to do |format|
  #     format.html { redirect_to memberships_url, notice: "Membership was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    flash.notice = "Membership was successfully destroyed."
      redirect_to memberships_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def membership_params
      params.require(:membership).permit(:user, :group, :meetup, :user_id, :group_id)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to memberships_path
    end
end
