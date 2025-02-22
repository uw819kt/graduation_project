# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_user = User.create(
  name: "admin",
  email: "admin@example.com",
  department: 0,
  password: "password",
  password_confirmation: "password",
  admin: true
)

normal_user = User.create(
  name: "normal",
  email: "normal@example.com",
  department: 1,
  password: "password",
  password_confirmation: "password",
  admin: false
)

admin_car = Car.create(
  company_car: "下関111あ1111",
  private_car: "",
  user_id: admin_user.id
)

normal_car = Car.create(
  company_car: "",
  private_car: "下関222あ2222",
  user_id: normal_user.id
)

admin_paid_leave = PaidLeave.create(
  joining_date: "2003-04-01",
  base_date: "2024-04-01",
  part_time: false,
  classification: nil,
  user_id: admin_user.id
)

normal_paid_leave = PaidLeave.create(
  joining_date: "2005-06-01",
  base_date: "2024-06-01",
  part_time: true,
  classification: 2,
  user_id: normal_user.id
)

Grant.create(
  granted_piece: 20,
  granted_day: "2024-10-01",
  user_id: admin_user.id,
  paid_leave_id: admin_paid_leave.id
)

Grant.create(
  granted_piece: 7,
  granted_day: "2024-12-01",
  user_id: normal_user.id,
  paid_leave_id: normal_paid_leave.id
)

Request.create(
  request_date: "2024-10-05",
  acquisition_date: "2024-10-13",
  user_id: admin_user.id,
  paid_leave_id: admin_paid_leave.id,
  paid_remarks: ""
)

Request.create(
  request_date: "2024-12-13",
  acquisition_date: "2024-12-20",
  user_id: normal_user.id,
  paid_leave_id: normal_paid_leave.id,
  paid_remarks: ""
)

Approval.create(
  request_date: "2024-10-05",
  acquisition_date: "2024-10-13",
  paid_applicable: true,
  user_id: admin_user.id,
  paid_leave_id: admin_paid_leave.id,
  paid_remarks: ""
)

Approval.create(
  request_date: "2024-12-13",
  acquisition_date: "2024-12-20",
  paid_applicable: false,
  user_id: normal_user.id,
  paid_leave_id: normal_paid_leave.id,
  paid_remarks: "介護休暇"
)

AlcoholLog.create(
  check_time: "2025-02-05 11:48:11.568272000 +0000",
  confirmation: 0,
  detector_used: true,
  result: 0.01,
  condition: 0,
  log_remarks: "",
  user_id: admin_user.id,
  car_id: admin_car.id,
  driving_status: 0
)

AlcoholLog.create(
  check_time: "2025-02-05 09:28:11.568272000 +0000",
  confirmation: 0,
  detector_used: true,
  result: 0.00,
  condition: 0,
  log_remarks: "",
  user_id: normal_user.id,
  car_id: normal_car.id,
  driving_status: 0
)