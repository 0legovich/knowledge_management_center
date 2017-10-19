class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    @user = params[:id].blank? ? current_user : User.find(params[:id])
  end

  def new
  end

  def create
    @user.role = Role.find(params[:user][:role_id])
    if @user.save
      flash[:notice] = "Профиль успешно создан"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @organizations = Organization.all
  end

  def update
    if update_params[:password].blank?
      update = true if @user.update_without_password(update_params)
    else
      update = true if @user.update_attributes(update_params)
    end

    if update
      flash[:notice] = "Профиль успешно обновлен"
      sign_in @user, bypass: true if @user.id == current_user.id
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def index
  end

  private

  def create_params
    parameters = [:first_name, :last_name, :patronymic, :birthday, :sex, :email, :password, :password_confirmation, :role_id]
    parameters.push(organization_ids: []) if params[:user][:role_id].to_i == Role.teacher.id
    parameters << :organization_ids if params[:user][:role_id].to_i == Role.learner.id

    params.require(:user).permit(parameters)
  end

  def update_params
    parameters = [:first_name, :last_name, :patronymic, :birthday, :sex, :email, :password, :password_confirmation]
    @user.destroy_organizations
    parameters.push(:role_id) if current_user.admin?
    parameters.push(organization_ids: []) if params[:user][:role_id].to_i == Role.teacher.id
    parameters << :organization_ids if params[:user][:role_id].to_i == Role.learner.id

    params.require(:user).permit(parameters)
  end
end
