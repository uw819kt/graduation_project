class AlcoholLogsController < ApplicationController
  before_action :set_alcohol_log, only: %i[ show edit update destroy ]

  # GET /alcohol_logs or /alcohol_logs.json
  def index
    @q = AlcoholLog.ransack(params[:q])

    if params[:q].nil?
      @q = AlcoholLog.ransack(check_time_gteq: Date.current, check_time_lteq: Date.current)
    else
      @q = AlcoholLog.ransack(params[:q])
    end
    
    @users = User.includes(:car, :alcohol_logs).all
    @before_driving_logs = @q.result.includes(:user).where(user_id: @users.ids, driving_status: 0).order(:check_time)
    @after_driving_logs = @q.result.includes(:user).where(user_id: @users.ids, driving_status: 1).order(:check_time)
  end

  # GET /alcohol_logs/1 or /alcohol_logs/1.json
  def show
    @before_driving_logs = AlcoholLog.where(user_id: current_user.id, driving_status: 0)
    @after_driving_logs = AlcoholLog.where(user_id: current_user.id, driving_status: 1)
  end

  # GET /alcohol_logs/new
  def new
    @alcohol_log = AlcoholLog.new(user_id: current_user.id, car_id: current_user.car.id)
    @alcohol_log.build_car
  end

  # POST /alcohol_logs or /alcohol_logs.json
  def create
    @alcohol_log = AlcoholLog.new(alcohol_log_params)
    @alcohol_log.user = current_user
    @alcohol_log.check_time = Time.zone.now
    @alcohol_log.build_car
    @alcohol_log.car_id = current_user.car.id

    respond_to do |format|
      if @alcohol_log.save
        format.html { redirect_to @alcohol_log, notice: "酒気帯びチェックの入力が完了しました" }
        format.json { render :show, status: :created, location: @alcohol_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alcohol_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /alcohol_logs/1/edit
  def edit
  end

  # PATCH/PUT /alcohol_logs/1 or /alcohol_logs/1.json
  def update
    respond_to do |format|
      if @alcohol_log.update(alcohol_log_params)
        format.html { redirect_to @alcohol_log, notice: "酒気帯びチェックの更新が完了しました" }
        format.json { render :show, status: :ok, location: @alcohol_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alcohol_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alcohol_logs/1 or /alcohol_logs/1.json
  def destroy
    @alcohol_log.destroy!

    respond_to do |format|
      format.html { redirect_to alcohol_logs_path, status: :see_other, notice: "Alcohol log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_alcohol_log
    @alcohol_log = AlcoholLog.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def alcohol_log_params
    params.require(:alcohol_log).permit(:check_time, :confirmation, :detector_used, :result, :condition, :log_remarks, :user_id, :car_id, :driving_status)
  end
end
