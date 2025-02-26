class RequestController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @paid_leave = current_user.paid_leave
    @request = @paid_leave.requests.build(request_params)
    @request.user = current_user

    if @request.save
      redirect_to paid_leaves_path, notice: "Request was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def request_params
    params.require(:request).permit(:request_date, :acquisition_date, :paid_remarks)
  end
end
