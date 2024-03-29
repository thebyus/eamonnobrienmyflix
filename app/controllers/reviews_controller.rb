class ReviewsController<ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(params.require(:review).permit(:rating, :content).merge!(user: current_user))
    if review.save
      redirect_to @video
    else
      @review = @video.reviews.reload
      render "videos/show"
    end
  end
end
