require 'rho/rhocontroller'
require 'helpers/browser_helper'

class UnitController < Rho::RhoController
  include BrowserHelper

  # GET /Unit
  def index
    @units = Unit.find(:all)
    render :back => '/app'
  end

 def search
  Unit.search(
    :from => 'search',
    :search_params => { 
      :Value => @params['unit']['value'], 
      :From => @params['unit']['from'], 
      :To => @params['unit']['to'] 
    },
    :callback => url_for(:action => :search_callback),
    :callback_param => ""
  )
render :action => :wait
 end

def search_callback
  status = @params["status"] 
  puts @params,"************************"
  Alert.show_popup("fhfhghjg")
end

  # GET /Unit/{1}
  def show
    @unit = Unit.find(@params['id'])
    if @unit
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Unit/new
  def new
    @unit = Unit.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Unit/{1}/edit
  def edit
    @unit = Unit.find(@params['id'])
    if @unit
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Unit/create
  def create
    @unit = Unit.create(@params['unit'])
    redirect :action => :index
  end

  # POST /Unit/{1}/update
  def update
    @unit = Unit.find(@params['id'])
    @unit.update_attributes(@params['unit']) if @unit
    redirect :action => :index
  end

  # POST /Unit/{1}/delete
  def delete
    @unit = Unit.find(@params['id'])
    @unit.destroy if @unit
    redirect :action => :index  
  end
end
