class InvitationsController<ApplicationController
  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:success] = "Congratulations, you have invited #{@invitation.recipient_name} to join MyFlix!"
      redirect_to new_invitation_path
    else
      flash[:error] = "You must enter valid information for all three fields."
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message).merge!(inviter_id: current_user.id)
  end
end
