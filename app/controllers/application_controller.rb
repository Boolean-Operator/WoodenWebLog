class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    #@current_user = @current_user|| User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    !!current_user
    #returns a boolean
  end

  def require_user
    if !logged_in?
      flash[:alert] = "I'm sorry Dave, but I cannot allow that.  You must be logged in to perform this action."
      redirect_to login_path
    end
  end

end
