class RoutesController < ApplicationController
  # GET /routes
  # GET /routes.xml
  def index
    if current_user
    @routes = Route.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @routes }
    end
  else
    flash.now.alert = "You need to be Logged!"
    render :template => 'routes/error'
  end
  end

  # GET /routes/1
  # GET /routes/1.xml
  def show
    @route = Route.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @route }
    end
  end

  # GET /routes/new
  # GET /routes/new.xml
  def new
    if current_user 
    @route = Route.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @route }
    end
    else
      flash.now.alert = "You need to be Logged!"
      render :template => 'routes/error' 
    end
  end

  # GET /routes/1/edit
  def edit
    @route = Route.find(params[:id])
  end

  # POST /routes
  # POST /routes.xml
  def create
    @route = Route.new(params[:route])
    flash.now.alert = @route.name + " was added to our catalog!"
    @route.participants << Participant.create(:user_id => current_user.id, :route_id => @route.id)  # Añadimos el usuario creador a la ruta.
    @route.save # Lo guardamos.

    respond_to do |format|
      if @route.save
        format.html { render :template => 'routes/congratulations'}
        format.xml  { render :xml => @route, :status => :created, :location => @route }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @route.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /routes/1
  # PUT /routes/1.xml
  def update
    @route = Route.find(params[:id])

    respond_to do |format|
      if @route.update_attributes(params[:route])
        format.html { redirect_to(@route, :notice => 'Route was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @route.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def subscribe # Creamos la suscripción.
    @route = Route.find(params[:id])  # Buscamos el usuario.
    @route.participants << Participant.create(:user_id => current_user.id, :route_id => @route.id)  # Creamos el participante.
    @route.save
    flash.now.alert = "You've just been subscribed!"
    render :template => 'routes/congratulations'   
  end
  def unsubscribe # Borramos el participante.
    id = params[:id]  # Cogemos el id.
    participant = Participant.where(:user_id => current_user.id, :route_id => id) # Buscamos la linea de la tabla buscada.
    Participant.destroy(participant)  # Los destruimos.
    redirect_to :action => 'index' 
  end
  # DELETE /routes/1
  # DELETE /routes/1.xml
  def destroy
    @route = Route.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to(routes_url) }
      format.xml  { head :ok }
    end
  end
  
  def error
  end
  def congratulations
  end
end
