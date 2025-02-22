  class Admin::UsersController < ApplicationController
    before_action :admin?
    before_action :set_user, only: %i[ show edit update destroy ]

    # GET /users or /users.json
    def index
      @users = User.includes(:car, :paid_leave).all
      @users = @users.order('paid_leaves.joining_date ASC')
      @cars = Car.all
      @paid_leaves = PaidLeave.all
    end

    # GET /users/1 or /users/1.json
    def show
    end

    # GET /users/new
    def new
      @user = User.new
      @user.paid_leave
      @registration_form = RegistrationForm.new
    end

    # GET /users/1/edit
    def edit
      @registration_form = RegistrationForm.new(user_attributes: @user, paid_leave_attributes: @user.paid_leave, car_attributes: @user.car)

      user = User.all
      part_time = PaidLeave.find_by(user_id: user.ids).part_time
      approvals = Approval.all
      classification = PaidLeave.pluck(:classification)
      adjustment_value = params[:adjustment_value].to_i
      adjustment_plan_value = params[:adjustment_plan_value].to_i
      adjustment_carry_value = params[:adjustment_carry_value].to_i

      service = Service.new(user, approvals, adjustment_value, classification)
      @discrimination = service.discrimination
      @carry_over = service.carry_over
      @total_days = service.total_days
      @adjusted_total_days = service.adjusted_total_days
      @adjusted_plan = service.adjusted_plan
      @adjusted_carry_over = service.adjusted_carry_over
    end

    # POST /users or /users.json
    def create
      @registration_form = RegistrationForm.new(user_attributes: user_params,
        paid_leave_attributes: paid_leave_params,
        car_attributes: car_params,
        grant_attributes: grant_params
        )
      
      if @registration_form.save
        flash[:notice] = "User was successfully created."
        redirect_to admin_users_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1 or /users/1.json
    def update
      @user = User.find(params[:id])
      @paid_leave = @user.paid_leave
      @car = @user.car
      @grant = @user.grant
      binding.irb
      @registration_form = RegistrationForm.new(user: @user.id, paid_leave: @paid_leave, car: @car, garant: @garant)

      if @registration_form.update(user_attributes: user_params, 
                                   paid_leave_attributes: paid_leave_params, 
                                   car_attributes: car_params
                                   )
        redirect_to admin_users_path, notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /users/1 or /users/1.json
    def destroy
      if @user.destroy
        flash[:notice] = 'user was successfully destroyed.'
        redirect_to admin_users_path, status: :see_other
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        redirect_to admin_user_path(@user), status: :unprocessable_entity
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation, :admin)
    end

    def paid_leave_params
      params.require(:paid_leave).permit(:joining_date, :part_time, :classification, :base_date, :user_id)
    end

    def car_params
      params.require(:car).permit(:company_car, :private_car, :user_id)
    end

    def grant_params
      params.require(:grant).permit(:granted_piece, :granted_day, :user_id, :paid_leave_id)
    end

    def admin?
      unless current_user.admin?
        flash[:danger] = "管理者以外アクセスできません"
        redirect_to paid_leaves_path
      end
    end
  end
