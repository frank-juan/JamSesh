class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || jams_path
  end

	protected

  def after_update_path_for(resource)
      user_path(resource)
    end

	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) << :username << :name << :email << :password << :password_confirmation << :remember_me << :jam_skill_id
	  devise_parameter_sanitizer.for(:sign_in) << :login << :password << :remember_me
    devise_parameter_sanitizer.for(:account_update) << :username << :name << :email << :password << :password_confirmation << :avatar << :location << :bio << :styles << :jam_skill_id << :user_instruments << :main_instrument << :influences << :equipment
	end
end
