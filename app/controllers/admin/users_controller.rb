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
      @user.build_car
      @user.build_paid_leave
      @user.build_grant
    end

    # POST /users or /users.json
    def create
      ActiveRecord::Base.transaction do
        @user = User.new(user_params)
        @paid_leave = @user.build_paid_leave(paid_leave_params)
        @grant = @paid_leave.build_grant(grant_params)
        @grant.user = @user
        @car = @user.build_car(car_params)
        
        if @user.save
          flash[:notice] = "社員情報の登録が完了しました"
          redirect_to admin_users_path
        else
        render :new, status: :unprocessable_entity
        end
      end
      rescue ActiveRecord::Rollback => e
      flash[:danger] = "Error: #{e.message}"            
    end

    # GET /users/1/edit
    def edit
      @user = User.find(params[:id])
      @paid_leave = @user.paid_leave
      @car = @user.car
      @grant = @user.grant

      user = User.all
      part_time = PaidLeave.find_by(user_id: user.ids).part_time
      base_date = PaidLeave.find_by(user_id: user.ids).base_date
      joining_date = PaidLeave.find_by(user_id: user.ids).joining_date
      approvals = Approval.all
      classification = PaidLeave.pluck(:classification)
      adjustment_value = params[:adjustment_value].to_i
      adjustment_plan_value = params[:adjustment_plan_value].to_i
      adjustment_carry_value = params[:adjustment_carry_value].to_i

      service = Service.new(user, approvals, adjustment_value, classification, base_date, joining_date)
      @discrimination = service.discrimination
      @carry_over = service.carry_over
      @total_days = service.total_days
      @adjusted_total_days = service.adjusted_total_days
      @adjusted_plan = service.adjusted_plan
      @adjusted_carry_over = service.adjusted_carry_over
    end

    # PATCH/PUT /users/1 or /users/1.json
    def update
      @user = User.find(params[:id])
      @paid_leave = @user.paid_leave
      @car = @user.car
      @grant = @user.grant

      if @user.update(user_params) && @paid_leave.update(paid_leave_params) && @car.update(car_params) && @grant.update(grant_params)
        redirect_to admin_users_path, notice: "社員情報の更新が完了しました"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /users/1 or /users/1.json
    def destroy
      if @user.destroy
        flash[:notice] = '社員情報の削除が完了しました'
        redirect_to admin_users_path, status: :see_other
      else
        flash[:danger] = @user.errors.full_messages.to_sentence
        redirect_to admin_user_path(@user), status: :unprocessable_entity
      end
    end

    def guest_sign_in
      user = User.find_or_create_by!(email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64
      end
      sign_in user
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :department, :admin, :password, :password_confirmation)
    end

    def paid_leave_params
      params.require(:paid_leave).permit(:joining_date, :base_date, :part_time, :classification)
    end

    def car_params
      params.require(:car).permit(:company_car, :private_car)
    end

    def grant_params
      params.require(:grant).permit(:granted_piece, :granted_day)
    end

    def admin?
      unless current_user.admin?
        flash[:danger] = "管理者以外アクセスできません"
        redirect_to paid_leaves_path
      end
    end
  end
