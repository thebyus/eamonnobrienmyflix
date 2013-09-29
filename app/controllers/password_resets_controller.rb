class PasswordResetsController <ApplicationController
  def show
    user = User.where(token: params[:id]).first
    @token = user.token if user
    redirect_to expired_token_path unless user
  end

  def create
    user = User.where(token:params[:token]).first
    if user
      user.password = params[:password]
      user.generate_token
      user.save
      flash[:success] = "Your password has been successfully changed. Please sign in using your new password."
      redirect_to sign_in_path
    else
      redirect_to expired_token_path
    end
  end
end
