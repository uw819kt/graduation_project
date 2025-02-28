class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲストユーザー' 
      user.department = 5
      user.admin = false
    end
    user.create_paid_leave(
      joining_date: Date.today,
      base_date: Date.today,    
      part_time: false,        
      classification: 4         
    )
    user.create_car(private_car: "", company_car: "下関111あ1111")
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def admin_guest_sign_in
    user = User.find_or_create_by(email: 'guest_admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = '管理者ゲストユーザー'
      user.department = 5
      user.admin = true 
    end
    user.create_paid_leave(
      joining_date: Date.today,
      base_date: Date.today,    
      part_time: false,        
      classification: 4         
    )
    user.create_car(private_car: "", company_car: "下関111あ1111")
    sign_in user
    redirect_to root_path, notice: '管理者ゲストユーザーとしてログインしました。'
  end
end
