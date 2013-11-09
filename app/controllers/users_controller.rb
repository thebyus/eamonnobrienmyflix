class UsersController<ApplicationController

  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => params[:stripeToken],
        :description => "Charge for #{@user.email} subscription to EamonnOBrienMyFlix"
        )
      if charge.successful?
        @user.save
        handle_invitation
        WelcomeBackgroundEmailer.perform_async(@user.id)
        session[:user_id] = @user.id
        flash[:success] = "Thank you for registering with MyFlix!"
        redirect_to home_path
      else
        flash[:error] = charge.error_message
        render :new
      end
    else
      flash[:error] = "Invalid user information. Please check the error message(s) below."
      render :new
    end
  end

  def show
    @user = User.find_by(token: params[:id])
  end

  def new_with_invitation_token

    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email, full_name: invitation.recipient_name)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private
    def user_params
      params.require(:user).permit!
    end

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end
end
