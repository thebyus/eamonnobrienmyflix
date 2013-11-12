class VideosController <ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = VideoDecorator.decorate(Video.find(params[:id]))
    @review = @video.reviews

  end

  def search
    @search_result = Video.search_by_title(params[:search_term])
  end
end
