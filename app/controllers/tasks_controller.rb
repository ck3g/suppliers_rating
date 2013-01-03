class TasksController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :js

  before_filter :find_supplier_service, only: [:new, :create]
  before_filter :find_task, only: [:show, :edit, :update, :destroy, :reopen]
  before_filter :find_comments, only: [:show, :reopen, :pay_to_supplier]

  def index
    @tasks = Task.order("created_at DESC").page(params[:page])
  end

  def new
    @task = @supplier_service.tasks.new
  end

  def new_from_scratch
    supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id].present?
    service = Service.find(params[:service_id]) if params[:service_id].present?
    @task = Task.init_from_supplier_and_service supplier, service
  end

  def create_from_scratch
    supplier = Supplier.where(id: params[:task].delete(:supplier_id)).first
    service = Service.where(id: params[:task].delete(:service_id)).first

    @task = Task.init_from_supplier_and_service supplier, service, params[:task]

    unless supplier
      flash.alert = t(:invalid_supplier)
      render :new_from_scratch
      return
    end

    unless service
      flash.alert = t(:invalid_service)
      render :new_from_scratch, alert: t(:invalid_service)
      return
    end

    supplier_service = SupplierService.where(supplier_id: supplier.id, service_id: service.id).first_or_initialize
    if supplier_service.new_record?
      supplier_service.price = params[:task][:cost].to_s.to_d
      supplier_service.save
    end

    @task.supplier_service = supplier_service
    if @task.save
      redirect_to root_path, notice: t(:successfully_created)
    else
      render :new_from_scratch
    end
  end

  def create
    @task = @supplier_service.tasks.new params[:task]
    if @task.save
      redirect_to callback_url, notice: t(:successfully_created)
    else
      render :new
    end
  end

  def show
  end

  def edit

  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to callback_url, notice: t(:successfully_updated)
    else
      render :edit
    end
  end

  def reopen
    @task.reopen!
    render :reload
  end

  def pay_to_supplier
    @task.pay_to_supplier!
    render :reload
  end

  def destroy
    @task.destroy
    redirect_to callback_url
  end

  private
  def find_task
    @task = Task.find params[:id]
  end

  def find_supplier_service
    @supplier_service = SupplierService.find params[:supplier_service_id]
  end

  def callback_url
    params[:callback_url] || tasks_path
  end

  def find_comments
    @comments = @task.comments.order(:created_at)
    @comment = @task.comments.new
  end
end

