class ReviewDecorator < Draper::Decorator
  delegate_all

  def rating
    if @review
      "#{@review.average('Rating')}"
    else
      "Be the first to rate this movie!"
    end
  end
end


