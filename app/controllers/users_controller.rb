class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :authorized, only: [:new, :create]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show    
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
   @user = User.new(user_params)
   @user.avatar.attach(user_params[:avatar])
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now.alert = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update 
    # TO DO: Don't drop avatar
    @user.avatar.attach(user_params[:avatar])
    if @user.update(user_params)
      flash.notice = "The user record was updated successfully."
      redirect_to @user
    else
      flash.now.alert = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "This user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def membership
    if @user.id.present?
      @membership = Membership.create(user_id: @user.id)
    end
  end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :user_id, :group_id)
    end

  def catch_not_found(e)
    Rails.logger.debug("We had a not found exception.")
    flash.alert = e.to_s
    redirect_to users_path
  end
end