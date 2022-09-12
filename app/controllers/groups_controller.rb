class GroupsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found 
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
      @group = Group.new(group_params)
      if @group.save
        flash.notice = "The group record was created successfully."
        redirect_to @group
      else
        flash.now.alert = @group.errors.full_messages.to_sentence
        render :new  
      end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    if @group.update(group_params)
      flash.notice = "The group record was updated successfully."
      redirect_to @group
    else
      flash.now.alert = @group.errors.full_messages.to_sentence
      render :edit
    end
  end
  
  # GET /groups or /groups.json
  def join
    @group = Group.find(params[:id])
    @membership = @group.memberships.build(:user_id => current_user.id)
    respond_to do |format|
      if @membership.save
        format.html { redirect_to(@group, :notice => 'You have joined this group.') }
        format.xml  { head :ok }
      else
        format.html { redirect_to(@group, :notice => 'Join error.') }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:title, :location, :user_id, :user)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to groups_path
    end
end
