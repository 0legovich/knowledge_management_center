class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => :get_select_options

  def show
    @user = params[:id].blank? ? current_user : User.find(params[:id])
  end

  def new
    @organizations = Organization.all
    @divisions = @user.divisions.all
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
    @divisions = @user.divisions.all
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

  def get_divs_for_hiding_and_showing
    if params[:role_id] == Role.admin.id.to_s
      render json: {
        "hide_div_id" => ["organizations_check_boxes",
                          "organizations_radio_buttons",
                          "divisions_select"],
        "show_div_id" => [""]}
    elsif params[:role_id] == Role.teacher.id.to_s
      render json: {
        "show_div_id" => ["organizations_check_boxes", "divisions_select"],
        "hide_div_id" => ["organizations_radio_buttons"],
        "multiply_divisions_select" => true
      }
    elsif params[:role_id] == Role.learner.id.to_s
      render json: {
        "show_div_id" => ["organizations_radio_buttons", "divisions_select"],
        "hide_div_id" => ["organizations_check_boxes"],
        "multiply_divisions_select" => false
      }
    end
  end

  def get_divisions
    organizations = params[:organizations].map {|i| Organization.find(i)}
    get_hash = {"organizations" => []}
    organizations.each do |o|
      get_hash["organizations"].push([o.id.to_s, o.name, o.divisions.map {|i| [i.id, i.name]}])
    end
    p get_hash
    render json: get_hash
  end

  private

  def create_params
    parameters = [:first_name, :last_name, :patronymic, :birthday, :sex, :email, :password, :password_confirmation, :role_id]
    if params[:user][:role_id].to_i == Role.teacher.id
      parameters.push(division_ids: [])
      parameters.push(organization_ids: [])
    end
    if params[:user][:role_id].to_i == Role.learner.id
      parameters << :organization_ids
      parameters.push(division_ids: [])
    end

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
