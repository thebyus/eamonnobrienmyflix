class Admin::VideosController < ApplicationController
  before_action :require_user
  before_action :require_admin

  def new
    @video = Video.new
  end

  def create
    category_ids = params[:video][:category_ids]
    category_ids = category_ids.delete_if{ |x| x.empty? }
    @video = Video.new(admin_add_video_params)
    if @video.save
      @video.categories << Category.find(category_ids)
#      require 'pry'; binding.pry
      flash[:success] = "You have successfully added '#{@video.title}'."
      redirect_to new_admin_video_path
    else
      flash[:error] = "You did not fill in all the fields correctly."
      render :new
    end
  end

  private

  def admin_add_video_params
    params.require(:video).permit(:title, :catgory_ids, :description, :large_cover, :small_cover, :video_url)
  end

  def require_admin
    if !current_user.admin?
    flash[:error] = "You are not authorized to do that!"
    redirect_to home_path
    end
  end
end