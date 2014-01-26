class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  has_many :reviews, order: "created_at DESC"

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  validates_presence_of :title, :description

  before_create :generate_token

  def self.search_by_title(search_term)
    Video.where("title like ?", "%#{search_term}%")
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
