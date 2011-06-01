class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def admin_required
    unless current_user.is_admin?
      flash[:error] = "You must be logged in as admin to access this section"
      redirect_to root_path
    end
  end
end
