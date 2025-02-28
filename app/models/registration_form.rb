class RegistrationForm
  include ActiveModel::Model
  # include ActiveModel::Attributes

  attr_accessor :name, :email, :department, :admin, :password, :password_confirmation, :joining_date, :part_time, 
    :classification, :company_car, :private_car, :base_date, :granted_piece, :granted_day, :paid_leave_id, :granted_day

  validates :name, :department, :joining_date, :base_date, :granted_piece, :granted_day, presence: true
  validates :admin, inclusion: { in: [true, false] }
  validates :part_time, inclusion: { in: [true, false] }
  validates :user_id, presence: true, on: :update
  validates :classification, presence: { allow_nil: true, allow_blank: true }, on: [:create, :update]                      
  validates :company_car, length: { maximum: 30 }
  validates :private_car, length: { maximum: 30 }
  validates :paid_leave_id, presence: true, on: :update

  # delegate :persisted?, to: :user, :paid_leave, :car, :grant

  def initialize(attributes = nil, user: User.new, paid_leave: PaidLeave.new, car: Car.new, grant: Grant.new)
    @user = user
    @paid_leave = paid_leave
    @car = car
    @grant = grant
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    ActiveRecord::Base.transaction do
      user = User.create(name:, email:, department:, password:, password_confirmation:)
      paid_leave = PaidLeave.create(user_id: user.id, joining_date:, base_date:, part_time:, classification:)
      Car.create(user_id: user.id, company_car:, private_car:)
      Grant.create(user_id: user.id, paid_leave_id:paid_leave.id, granted_piece:, granted_day:)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end


  private

  attr_reader :user, :paid_leave, :car, :grant

  def default_attributes
    {
      name: user.name, 
      email: user.email, 
      department: user.department, 
      password: user.password, 
      password_confirmation: user.password, 
      joining_date: paid_leave.joining_date, 
      base_date: paid_leave.base_date, 
      part_time: paid_leave.part_time, 
      classification: paid_leave.classification,
      company_car: car.company_car,
      private_car: car.private_car,
      granted_piece: grant.granted_piece,
      granted_day: grant.granted_day,
      paid_leave_id: paid_leave.id
    }
  end
end