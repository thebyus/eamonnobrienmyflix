class ForgotPasswordsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    if user
      ForgotPasswordBackgroundEmailer.perform_async(user.id)
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank!" : "That email is not associated with any registered user"
      redirect_to forgot_password_path
    end
  end
end
