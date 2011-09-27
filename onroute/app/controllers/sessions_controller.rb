class SessionsController < ApplicationController
  def new
  end

  def create  # Creamos la sesión.
    user = User.authenticate(params[:email], params[:password]) # Autenticamos el usuario y lo guardamos.
    if user # Si existe...
      session[:user_id] = user.id # Creamos la sesión del usuario.
      redirect_to root_url, :notice => "Logged in!" 
    else  # Si no se encuentra...
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy # Destruimos la sesión. 
    session[:user_id] = nil # Borramos la sesión del usuario.
    flash.now.alert = "You've been disconneted!"
      render :template => 'routes/error'  
  end
end
