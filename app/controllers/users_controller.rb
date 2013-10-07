class UsersController<ApplicationController

  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      AppMailer.send_welcome_email(@user).deliver
      session[:user_id] =@user.id
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by(token: params[:id])
  end

  private
    def user_params
      params.require(:user).permit!

    end

end
