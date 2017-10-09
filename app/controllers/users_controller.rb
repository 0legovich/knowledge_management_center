class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
