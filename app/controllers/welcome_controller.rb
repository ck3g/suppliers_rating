class WelcomeController < ApplicationController
  def index
    @suppliers = SuppliersLoader.list.page(params[:page])
  end
end
