class Admin::UsersController < Admin::BaseController
  def index
    @users = AllUsersQuery.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "The user's settings were successfully updated"
    else
      render :edit
    end
  end

  private

    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :password_confirmation, :time_zone, :role)
    end
end
