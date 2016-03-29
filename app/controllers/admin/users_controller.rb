class Admin::UsersController < ApplicationController
  before_action :check_authorization

  def index
    @users = User.all
  end

  protected

  def check_authorization
    unless current_user.is_admin
      flash[:error] = "Unauthorized access"
      redirect_to root_path
      false
    end
  end

end
