class SessionsController<ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      if user.active?
        session[:user_id] = user.id
        redirect_to home_path, notice: 'You are now signed in!'
      else
        flash[:error] = "Your account has been suspended. Please contact Customer Service."
        redirect_to sign_in_path
      end
    else
      flash[:error] = "Sorry, invalid email or password. Please try again!"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully signed out!"
  end
end
