class TasksController < ApplicationController
  load_and_authorize_resource

  respond_to :html, :js

  before_filter :find_supplier_service, only: [:new, :create]
  before_filter :find_task, only: [:show, :edit, :update, :destroy, :reopen]
  before_filter :find_comments, only: [:show, :reopen]

  def index
    @tasks = Task.order("created_at DESC").page(params[:page])
  end

  def new
    @task = @supplier_service.tasks.new
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
