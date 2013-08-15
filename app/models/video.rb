class Video < ActiveRecord::Base
	has_many :video_categories
	has_many :categories, through: :video_categories
  has_many :reviews

	validates_presence_of :title, :description

	def self.search_by_title(search_term)
		Video.where("title LIKE ?", "%#{search_term}%")
	end

end