class Category <ActiveRecord::Base
	has_many :video_categories
	has_many :videos, through: :video_categories, order: "created_at DESC"
  validates_presence_of :cat

	def recent_videos
		videos.first(6)
	end

end
