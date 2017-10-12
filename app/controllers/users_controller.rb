class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    @user = params[:id].blank? ? current_user : @user = User.find(params[:id])
  end
  def index
    @users = User.all
  end
end
