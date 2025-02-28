class Service
# 計算用クラス
  attr_accessor :user, :approvals, :paid_leave, :adjustment_value,
    :adjustment_plan_value, :adjustment_carry_value, :part_time, :classification, :base_date, :joining_date

  def initialize(user, approvals, adjustment_value = 0, adjustment_plan_value = 0, adjustment_carry_value = 0, part_time, classification, base_date, joining_date)
    @user = user
    @paid_leave = paid_leave
    @approvals = approvals
    @adjustment_value = adjustment_value
    @adjustment_plan_value = adjustment_plan_value
    @adjustment_carry_value = adjustment_carry_value
    @part_time = part_time
    @classification = classification
    @base_date = base_date
    @joining_date = joining_date
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
    discrimination = self.discrimination
    achievements = self.achievements
    
    @total_days = (carry_over + discrimination.to_i) - achievements.to_i
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
    @items = approvals.where(paid_applicable: true).group("EXTRACT(MONTH FROM acquisition_date)").count
  end

  def years_of_service # 勤続年数
    reference = (base_date - joining_date).to_i/ 365.25
    @years_of_service = reference.round(1)
  end

  def adjusted_plan # 有給休暇付与予定日数(調整)
    discrimination = self.discrimination
    @adjusted_plan = total_days + @adjustment_plan_value
  end

  def discrimination # 有給休暇付与日数表示
    if @part_time == true
      part_time_plan
      # パート社員の場合
    else
      full_time_plan
      # 正社員の場合
    end
  end


  private

  def part_time_plan # 有給休暇付与予定日数
    years_of_service = self.years_of_service.to_f
    if @classification == "4days_w" # 週4日＆30時間以下の場合
      if 0.5 <= years_of_service && years_of_service < 1.5
        @part_time_plan = 7
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @part_time_plan = 8
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @part_time_plan = 9
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @part_time_plan = 10
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @part_time_plan = 12
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @part_time_plan = 13  
      elsif years_of_service >= 6.5
        @part_time_plan = 15
      end       
    elsif classification == "3days_w"  # 週3日＆30時間以下の場合  
      if 0.5 <= years_of_service && years_of_service < 1.5
        @part_time_plan = 5
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @part_time_plan = 6
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @part_time_plan = 6
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @part_time_plan = 8
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @part_time_plan = 9
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @part_time_plan = 10  
      elsif years_of_service >= 6.5
        @part_time_plan = 11
      end 
    elsif classification == "2days_w"  # 週2日＆30時間以下の場合  
      if 0.5 <= years_of_service && years_of_service < 1.5
        @part_time_plan = 3
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @part_time_plan = 4
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @part_time_plan = 4
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @part_time_plan = 5
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @part_time_plan = 6
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @part_time_plan = 6  
      elsif years_of_service >= 6.5
        @part_time_plan = 7
      end
    elsif classification == "1days_w"  # 週1日＆30時間以下の場合  
      if 0.5 <= years_of_service && years_of_service < 1.5
        @part_time_plan = 1
      elsif 1.5 <= years_of_service && years_of_service < 2.5
        @part_time_plan = 2
      elsif 2.5 <= years_of_service && years_of_service < 3.5
        @part_time_plan = 2
      elsif 3.5 <= years_of_service && years_of_service < 4.5
        @part_time_plan = 2
      elsif 4.5 <= years_of_service && years_of_service < 5.5
        @part_time_plan = 3
      elsif 5.5 <= years_of_service && years_of_service < 6.5
        @part_time_plan = 3  
      elsif years_of_service >= 6.5
        @part_time_plan = 3
      end
    else
      @part_time_plan = 0     
    end
  end  

  def full_time_plan
    years_of_service = self.years_of_service.to_f

    if 0.5 <= years_of_service && years_of_service < 1.5
      @full_time_plan = 10
    elsif 1.5 <= years_of_service && years_of_service < 2.5
      @full_time_plan = 11
    elsif 2.5 <= years_of_service && years_of_service < 3.5
      @full_time_plan = 12
    elsif 3.5 <= years_of_service && years_of_service < 4.5
      @full_time_plan = 14
    elsif 4.5 <= years_of_service && years_of_service < 5.5
      @full_time_plan = 16
    elsif 5.5 <= years_of_service && years_of_service < 6.5
      @full_time_plan = 18  
    elsif years_of_service >= 6.5
      @full_time_plan = 20
    else
      @full_time_plan = 0     
    end
    @full_time_plan
  end
end
