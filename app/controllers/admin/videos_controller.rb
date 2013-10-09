class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(admin_add_video_params)
    if @video.save
      flash[:success] = "You have successfully added '#{@video.title}'."
      redirect_to new_admin_video_path
    else
      flash[:error] = "You did not fill in all the fields correctly."
      render :new
    end
  end

  private

  def admin_add_video_params
    params.require(:video).permit!
  end

  def require_admin
    if !current_user.admin?
    flash[:error] = "You are not authorized to do that!"
    redirect_to home_path
    end
  end
end
