class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  # before_action :organization_params, only: [:create, :update]

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
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
