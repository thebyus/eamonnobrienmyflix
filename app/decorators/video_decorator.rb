class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    object.rating.present? ? "#{object.rating/5.0}" : "Be the first to rate this video!"
  end
end
