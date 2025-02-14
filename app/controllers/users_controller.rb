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
    @user.paid_leaves.build
    @user.cars.build
    # @paid_leave = PaidLeave.new
    # @car = Car.new
    # @user.paid_leaves.build
    # @user.cars.build
  end

  # GET /users/1/edit
  def edit
    @paid_leave = @user.paid_leaves
    @grant = @user.grants.build

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
    if @user.save
      flash[:notice] = "User was successfully created."
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
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
      params.require(:user).permit(
        :name, :mail, :department, :password_digest, :admin, 
        paid_leaves_attributes: [:user_id, :joining_date, :part_time, :base_date, :classifications],
        cars_attributes: [:user_id, :company_car, :private_car],
        grants_attributes: [:user_id, :granted_piece]
        )
    end
end
