class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all.page(params[:page]).per(10).order(:id)
  end

  def show
    user_selected
    @reviews = @user.reviews
  end

  def edit
    user_selected
  end

  def update
    user_selected
    @user.update_attributes(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User account updated successfully"
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save!
      
      redirect_to admin_users_path, notice: "User successfully created!"
    else
      render :new
    end
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

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin)
  end

end
