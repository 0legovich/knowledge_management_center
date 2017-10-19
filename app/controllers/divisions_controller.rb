class DivisionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @division.save
      flash[:notice] = "Подразделение создано"
      redirect_to division_path(@division)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def division_params
    params.require(:division).permit(:name, :organization_id)
  end
end
