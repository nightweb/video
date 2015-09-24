class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :user_logged?, :permission?, :controller?, :action?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def user_logged?
    !!current_user
  end
  
  def permission?
    user = current_user.role.name if current_user
    if user == 'admin'
      true
    else
      false
    end
  end
  
  def action?(*action)
    action.include?(params[:action])
  end
  
  def controller?(*controller)
    controller.include?(params[:controller])
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
end
