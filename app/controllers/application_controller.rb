class ApplicationController < ActionController::Base
  # include Devise::Test::ControllerHelpers
  include Devise::Controllers::Helpers
  include RestaurantsHelper

  helper_method :current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead. before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :email, :password, :password_confirmation])
  end
end
