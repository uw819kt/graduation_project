class Service
# 計算用クラス
  attr_accessor :user, :approvals, :paid_leafe, :adjustment_value, :adjustment_plan_value, :adjustment_carry_value

  def initialize(user, approvals, adjustment_value = 0, adjustment_plan_value = 0, adjustment_carry_value = 0)
    @user = user
    @paid_leafe = paid_leafe
    @approvals = approvals
    @adjustment_value = adjustment_value
    @adjustment_plan_value = adjustment_plan_value
    @adjustment_carry_value = adjustment_carry_value
  end

  def carry_over # 前年度繰越分
    # 社内規則で有効期限が1年前の基準日～基準日前日まで→繰り越し0
    @carry_over ||= 0
    @carry_over
  end

  def adjusted_carry_over # 前年度繰越分(調整)
    carry_over = self.carry_over
    @adjusted_carry_over = carry_over + @adjustment_carry_value
  end

  def total_days # 有給保有日数
    carry_over = self.carry_over
    plan = self.plan
    achievements = self.achievements
    
    @total_days = (carry_over + plan.to_i) - achievements.to_i
  end

  def adjusted_total_days # 有給保有日数(調整)
    total_days = self.total_days
    @adjusted_total_days = total_days + @adjustment_value
  end

  def achievements # 有給休暇取得数（実績）
    # @achievements = Approval.group(:paid_applicable).where(paid_applicable: true).count
    @achievements = @approvals.select { |a| a.paid_applicable == true }.count
  end

  def items # 有給休暇取得数（月別）
    @items = approvals.group("EXTRACT(MONTH FROM acquisition_date)").count
  end

  def years_of_service # 勤続年数
    base_date = PaidLeave.pluck(:base_date)
    joining_date = PaidLeave.pluck(:joining_date)

    reference = base_date.zip(joining_date).map { |base_date, joining_date|(base_date - joining_date).to_i/ 365.25 }
    @years_of_service = reference.map { |num| num.round(1)}.join
  end

  def adjusted_plan # 有給休暇付与予定日数(調整)
    plan = self.plan
    @adjusted_plan = total_days + @adjustment_plan_value
  end

  def plan # 有給休暇付与予定日数
    years_of_service = self.years_of_service.to_f
    part_time_values = PaidLeave.where(user_id: @user).pluck(:part_time)

    if part_time_values.include?(false) # 正社員の場合
      if 0.5 <= years_of_service && years_of_service < 1.5
        @plan = "10"
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @plan = "11"
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @plan = "12"
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @plan = "14"
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @plan = "16"
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @plan = "18"  
      else years_of_service >= 6.5
        @plan = "20"     
      end
    elsif part_time_values.include?(true) && classification == 0 # 週4日＆30時間以下の場合
      if 0.5 <= years_of_service && years_of_service < 1.5
        @plan = "7"
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @plan = "8"
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @plan = "9"
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @plan = "10"
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @plan = "12"
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @plan = "13"  
      elsif years_of_service >= 6.5
        @plan = "15"
      end       
    elsif part_time_values.include?(true) && classification == 1  # 週3日＆30時間以下の場合  
      if 0.5 <= years_of_service && years_of_service < 1.5
        @plan = "5"
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @plan = "6"
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @plan = "6"
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @plan = "8"
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @plan = "9"
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @plan = "10"  
      elsif years_of_service >= 6.5
        @plan = "11"
      end 
    elsif part_time_values.include?(true) && classification == 2  # 週2日＆30時間以下の場合  
      if 0.5 <= years_of_service && years_of_service < 1.5
        @plan = "3"
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @plan = "4"
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @plan = "4"
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @plan = "5"
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @plan = "6"
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @plan = "6"  
      elsif years_of_service >= 6.5
        @plan = "7"
      end
    elsif part_time_values.include?(true) && classification == 3  # 週1日＆30時間以下の場合  
      if 0.5 <= years_of_service && years_of_service < 1.5
        @plan = "1"
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @plan = "2"
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @plan = "2"
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @plan = "2"
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @plan = "3"
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @plan = "3"  
      elsif years_of_service >= 6.5
        @plan = "3"
      end
    else
      @plan = "0"     
    end
    @plan
  end  
end  
