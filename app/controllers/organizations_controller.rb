class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  # before_action :organization_params, only: [:create, :update]

  def index
  end

  def show
  end

  def new
  end

  def create
    if @organization.save
      redirect_to organizations_path, notice: "Организация успешно создана"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_path, notice: "Организация успешно обновлена"
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def organization_params
    params.require(:organization).permit(:full_name, :short_name, :address)
  end
end
