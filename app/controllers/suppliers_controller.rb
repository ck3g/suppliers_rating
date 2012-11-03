class SuppliersController < ApplicationController
  load_and_authorize_resource
  before_filter :find_supplier, only: [:show, :update, :destroy]

  def index
    @suppliers = Supplier.order(:name).page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    @supplier = Supplier.new params[:supplier]
    if @supplier.save
      redirect_to suppliers_path, notice: t(:successfully_created)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @supplier.update_attributes params[:supplier]
      redirect_to suppliers_path, notice: t(:successfully_updated)
    else
      render :edit
    end
  end

  def destroy
    @supplier.destroy
    redirect_to suppliers_path
  end

  private
  def find_supplier
    @supplier = Supplier.find params[:id]
  end
end
