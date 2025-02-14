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
    @registration_form = RegistrationForm.new
  end

  # GET /users/1/edit
  def edit
    @registration_form = RegistrationForm.new

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
    @registration_form = RegistrationForm.new(user_attributes: user_params,
                                              paid_leave_attributes: paid_leave_params,
                                              car_attributes: car_params)

    if @registration_form.save
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
        redirect_to @user, notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
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

  def paid_leave_params
    params.require(:paid_leave).permit(:joining_date, :part_time, :classification, :base_date)
  end

  def car_params
    params.require(:car).permit(:company_car, :private_car)
  end
end
