class ReviewsController<ApplicationController
  def create
    video = Video.find(params[:video_id])
    video.reviews.create(params.require(:review).permit(:rating, :content))
    redirect_to video
  end
end
