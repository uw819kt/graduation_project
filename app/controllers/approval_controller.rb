class ApprovalController < ApplicationController
  def new
    @approval = Approval.new
  end

  def create 
    @paid_leave = current_user.paid_leave
    @approval = @paid_leave.approvals.build(approval_params)
    @approval.user = current_user

    if @approval.save
      redirect_to paid_leaves_path, notice: "有給休暇の申請が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @approval = Approval.find(params[:id])
  end

  def update
    @approval = Approval.find(params[:id])
    if @approval.update(approval_params)
      flash[:notice] = '有給休暇の申請を更新しました'
      redirect_to paid_leaves_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def approval_params
    params.require(:approval).permit(:request_date, :acquisition_date, :paid_applicable, :paid_remarks)
  end
end
