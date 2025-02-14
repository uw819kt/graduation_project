class RegistrationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :user_attributes, :paid_leave_attributes, :car_attributes, :grant_attributes

  validate :user_validate
  validate :paid_leave_validate
  validate :car_validate
  validate :grant_validate

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      save!
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def save!
    user.save!
  end

  def user
    @user ||= User.new(user_attributes)
  end

  def paid_leave
    @paid_leave ||= user.build_paid_leave(paid_leave_attributes)
  end

  def car
    @car ||= user.build_car(car_attributes)
  end

  def grant
    @grant ||= user.build_grant(grant_attributes)
  end


  private

  def user_validate
    return unless user.invalid?

    user.errors.full_messages.each do |message|
      errors.add(:base, message)
    end
  end

  def paid_leave_validate
    return unless paid_leave.invalid?

    paid_leave.errors.full_messages.each do |message|
      errors.add(:base, message)
    end
  end

  def car_validate
    return unless car.invalid?

    car.errors.full_messages.each do |message|
      errors.add(:base, message)
    end
  end

  def grant_validate
    return unless grant.invalid?

    grant.errors.full_messages.each do |message|
      errors.add(:base, message)
    end
  end
end