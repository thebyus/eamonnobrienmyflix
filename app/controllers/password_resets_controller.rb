class PasswordResetsController <ApplicationController
  def show
    user = User.where(token: params[:id]).first
    @token = user.token if user
    redirect_to expired_token_path unless user
  end

  def create

  end
end
