class SupplierServicesController < ApplicationController
  load_and_authorize_resource

  before_filter :find_supplier_service, only: [:edit, :update, :destroy]

  def new
    @supplier_service = SupplierService.new params.slice(:supplier_id, :service_id)
  end

  def create
    @supplier_service = SupplierService.new params[:supplier_service]
    if @supplier_service.save
      redirect_to callback_url, notice: t(:successfully_created)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @supplier_service.update_attributes params[:supplier_service]
      redirect_to callback_url, notice: t(:successfully_updated)
    else
      render :edit
    end
  end

  def destroy
    @supplier_service.destroy
    redirect_to callback_url
  end

  private
  def find_supplier_service
    @supplier_service = SupplierService.find params[:id]
  end

  def callback_url
    params[:callback_url] || suppliers_path
  end
end
