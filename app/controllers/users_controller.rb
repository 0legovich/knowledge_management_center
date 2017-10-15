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
    params.require(:user).permit(:first_name, :last_name, :patronymic, :birthday, :sex, :email, :password, :password_confirmation, :role_id)
  end

  def update_params
    if current_user.admin?
      params.require(:user).permit(:first_name, :last_name, :patronymic, :role_id, :birthday, :sex, :email, :password, :password_confirmation, :organization_ids)
    else
      params.require(:user).permit(:first_name, :last_name, :patronymic, :birthday, :sex, :email, :password, :password_confirmation)
    end
  end
end
