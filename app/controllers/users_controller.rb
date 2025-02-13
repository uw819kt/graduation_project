class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    @cars = Car.all
    @paid_leaves = PaidLeave.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @paid_leave = PaidLeave.new
  end

  # GET /users/1/edit
  def edit
    @paid_leave = @user.paid_leaves.build
    @approval = Approval.all

    user = User.all
    part_time = PaidLeave.find_by(user_id: user.ids).part_time
    approvals = Approval.all
    classification = PaidLeave.pluck(:classification)
    adjustment_value = params[:adjustment_value].to_i
    adjustment_plan_value = params[:adjustment_plan_value].to_i
    adjustment_carry_value = params[:adjustment_carry_value].to_i

    service = Service.new(user, approvals, adjustment_value)
    @plan = service.plan
    @carry_over = service.carry_over
    @total_days = service.total_days
    @adjusted_total_days = service.adjusted_total_days
    @adjusted_plan = service.adjusted_plan
    @@adjusted_carry_over = service.adjusted_carry_over
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :mail, :department, :password_digest, :admin)
    end
end
