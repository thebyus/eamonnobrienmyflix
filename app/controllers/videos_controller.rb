class VideosController <ApplicationController
  before_action :require_user

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def show
    @video = User.find_by(token: params[:id])
#    require 'pry'; binding.pry
    @review = @video.reviews

  end

  def search
    @search_result = Video.search_by_title(params[:search_term])
  end
end
