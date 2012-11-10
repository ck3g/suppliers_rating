class ServicesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_service, only: [:edit, :update, :destroy]

  autocomplete :service, :name, full: true

  has_scope :term

  def index
    @services = apply_scopes(ServicesLoader.list).page(params[:page])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new params[:service]
    if @service.save
      redirect_to services_path, notice: t(:successfully_created)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update_attributes(params[:service])
      redirect_to services_path, notice: t(:successfully_updated)
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to services_path
  end

  private
  def find_service
    @service = Service.find params[:id]
  end
end
