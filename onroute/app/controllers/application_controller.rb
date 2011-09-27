class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private
# Creamos la variable global current_user si no existe, operador "||=". Le pasamos el
#   valor usuario que está guardado en la sesión actual.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
