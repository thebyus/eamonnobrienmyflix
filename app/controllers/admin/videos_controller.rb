class Admin::VideosController < AdminsController

  def new
    @video = Video.new
  end

  def create
    category_ids = params[:video][:category_ids]
    category_ids = category_ids.delete_if{ |x| x.empty? }
#    require 'pry'; binding.pry
    @video = Video.new(admin_add_video_params)
    if @video.save
      @video.categories << Category.find(category_ids)
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
end
