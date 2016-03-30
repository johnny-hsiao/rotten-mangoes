class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all.page(params[:page]).per(3).order(:id)
  end

  def show
    user_selected
    @reviews = @user.reviews
  end

  def destroy
    user_selected
    @user.destroy
    redirect_to admin_users_path
  end

  protected

  def user_selected
    @user = User.find(params[:id])
  end

end
