class VideosController <ApplicationController
	
	def index
		@videos = Video.all
		@categories = Category.all
	end

	def show
		@video = Video.find(params[:id])
	end

	def search
		@search = Video.search_by_title(params[:title])
	end
end