class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories

	validates :title, presence: true
	validates :description, presence: true

	def self.search_by_title(search_term)
		Video.title.where(["name LIKE :tag", {:tag => search_term}])
	end

end