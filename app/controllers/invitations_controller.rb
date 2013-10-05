class InvitationsController<ApplicationController
  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.create(invitation_params)
    if @invitation
#      require 'pry' ; binding.pry
      AppMailer.send_invitation_email(@invitation).deliver
      redirect_to new_invitation_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message).merge!(inviter_id: current_user.id)
  end
end
