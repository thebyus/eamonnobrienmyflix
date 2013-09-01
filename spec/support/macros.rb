def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def create_review
  post :create, review: {rating: 4}, video_id: video.id
end
