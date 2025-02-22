class PaidLeavesController < ApplicationController
  before_action :set_paid_leafe, only: %i[ show edit update destroy ]

  # GET /paid_leaves or /paid_leaves.json
  def index
    @users = User.includes(:paid_leave, :alcohol_logs, :approvals).all
    @users = @users.order('paid_leaves.id ASC')
    
    @user_service = @users.map do |user|
      approvals = Approval.where(user_id: user.id)
      part_time = user.paid_leave.part_time
      classification = user.paid_leave.classification
      service = Service.new(user, approvals, part_time, classification)

      {
        user: user,
        discrimination: service.discrimination,
        achievements: service.achievements,
        items: service.items
      }
    end
  end
  
  # GET /paid_leaves/1 or /paid_leaves/1.json
  def show
    @users = User.find(params[:id])

    user = User.all
    part_time = PaidLeave.pluck(:part_time)
    approvals = Approval.all
    classification = PaidLeave.pluck(:classification)

    service = Service.new(user, approvals, part_time, classification)
    @achievements = service.achievements
    @discrimination = service.discrimination
    @total_days = service.total_days
    @items = service.items
    @carry_over = service.carry_over
  end

  # GET /paid_leaves/new
  def new
    @paid_leafe = PaidLeave.new
    @paid_leafe.approvals.build
  end

  # GET /paid_leaves/1/edit
  def edit
  end

  # POST /paid_leaves or /paid_leaves.json
  def create
    @paid_leafe = PaidLeave.new(paid_leafe_params)
    @paid_leafe.user = current_user
    if @paid_leafe.save
      redirect_to @paid_leafe, notice: "Paid leave was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /paid_leaves/1 or /paid_leaves/1.json
  def update
    if @paid_leafe.update(paid_leafe_params)
      redirect_to @paid_leafe, notice: "Paid leave was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /paid_leaves/1 or /paid_leaves/1.json
  def destroy
    @paid_leave.grants.destroy_all if paid_leave.grants.any?
    @paid_leafe.destroy!

    respond_to do |format|
      format.html { redirect_to paid_leaves_path, status: :see_other, notice: "Paid leave was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paid_leafe
      @paid_leafe = PaidLeave.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paid_leafe_params
      params.require(:paid_leave).permit(:joining_date, :base_date, :part_time, :user_id, :paid_remarks, approve_attributes: [:request_date, :acquisition_date, :paid_remarks])
    end
end
