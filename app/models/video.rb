class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories

	validates :title, presence: true
	validates :description, presence: true

	def self.search_by_title(title)
		Video.where("title LIKE ?", "%#{title}%")
	end

end