class PaidLeavesController < ApplicationController
  before_action :set_paid_leafe, only: %i[ show edit update destroy ]

  # GET /paid_leaves or /paid_leaves.json
  def index
    @paid_leaves = PaidLeave.all
  end

  # GET /paid_leaves/1 or /paid_leaves/1.json
  def show
  end

  # GET /paid_leaves/new
  def new
    @paid_leafe = PaidLeave.new
  end

  # GET /paid_leaves/1/edit
  def edit
  end

  # POST /paid_leaves or /paid_leaves.json
  def create
    @paid_leafe = PaidLeave.new(paid_leafe_params)

    respond_to do |format|
      if @paid_leafe.save
        format.html { redirect_to @paid_leafe, notice: "Paid leave was successfully created." }
        format.json { render :show, status: :created, location: @paid_leafe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @paid_leafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paid_leaves/1 or /paid_leaves/1.json
  def update
    respond_to do |format|
      if @paid_leafe.update(paid_leafe_params)
        format.html { redirect_to @paid_leafe, notice: "Paid leave was successfully updated." }
        format.json { render :show, status: :ok, location: @paid_leafe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @paid_leafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paid_leaves/1 or /paid_leaves/1.json
  def destroy
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
      params.require(:paid_leafe).permit(:joining_date, :base_date, :part_time, :user_id, :paid_remarks)
    end
end
