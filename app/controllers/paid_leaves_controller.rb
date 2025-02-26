class PaidLeavesController < ApplicationController
  before_action :set_paid_leave, only: %i[ show ]

  # GET /paid_leaves or /paid_leaves.json
  def index
    @users = User.includes(:paid_leave, :alcohol_logs, :requests, :approvals).all
    @users = @users.order('paid_leaves.id ASC')
    
    @user_service = @users.map do |user|
      approvals = Approval.where(user_id: user.id)
      part_time = user.paid_leave.part_time
      classification = user.paid_leave.classification
      base_date =  user.paid_leave.base_date
      joining_date = user.paid_leave.joining_date
      service = Service.new(user, approvals, part_time, classification, base_date, joining_date)

      {
        user: user,
        discrimination: service.discrimination,
        achievements: service.achievements,
        items: service.items,
        paid_leave: user.paid_leave,
      }
    end
  end
  
  # GET /paid_leaves/1 or /paid_leaves/1.json
  def show
    user = PaidLeave.find(params[:id])
    part_time =  @paid_leave.part_time
    approvals = Approval.all
    classification = @paid_leave.classification
    base_date = @paid_leave.base_date
    joining_date = @paid_leave.joining_date

    service = Service.new(user, approvals, part_time, classification, base_date, joining_date)
    @achievements = service.achievements
    @discrimination = service.discrimination
    @total_days = service.total_days
    @items = service.items
    @carry_over = service.carry_over
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paid_leave
      @paid_leave = PaidLeave.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paid_leave_params
      params.require(:paid_leave).permit(:joining_date, :base_date, :part_time, :user_id, :paid_remarks, request_atteibutes: [:request_date, :acquisition_date, :paid_remarks], approve_attributes: [:id, :request_date, :acquisition_date, :paid_remarks])
    end
end
