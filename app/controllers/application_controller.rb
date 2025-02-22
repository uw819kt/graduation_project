class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  
  private

  def after_sign_in_path_for(resource)
    paid_leaves_path 
  end

  def admin?
    unless current_user.admin
      redirect_to paid_leaves_path
    end
  end
end
