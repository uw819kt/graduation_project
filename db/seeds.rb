# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  name: "admin",
  email: "admin@example.com",
  department: 0,
  password_digest: "password",
  admin: true
)

car = Car.create(
  company_car: "下関111あ1111",
  private_car: "",
  user_id: user.id
)

paid_leave = PaidLeave.create(
  joining_date: "2003-04-01",
  base_date: "2024-04-01",
  part_time: false,
  classification: "",
  user_id: user.id
)

Grant.create(
  granted_piece: 20,
  granted_day: "2024-10-01",
  user_id: user.id,
  paid_leave_id: paid_leave.id
)

Request.create(
  request_date: "2024-10-05",
  acquisition_date: "2024-10-13",
  user_id: user.id,
  paid_leave_id: paid_leave.id,
  paid_remarks: ""
)

Approval.create(
  request_date: "2024-10-05",
  acquisition_date: "2024-10-13",
  paid_applicable: true,
  user_id: user.id,
  paid_leave_id: paid_leave.id,
  paid_remarks: ""
)

AlcoholLog.create(
  check_time: "2025-02-05 11:48:11.568272000 +0000",
  confirmation: 0,
  detector_used: true,
  result: 0.01,
  condition: 0,
  log_remarks: "",
  user_id: 1,
  car_id: 1,
  driving_status: 0
)