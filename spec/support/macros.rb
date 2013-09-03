def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def create_video
  @video = Fabricate(:video)
end

def create_user
  @user = Fabricate(:user)
end

def create_cosby_video
  Video.create!(title: "The Cosby Show", description: "NYC mom and dad struggle to raise their children", created_at: 1.day.ago)
end

def create_big_bang_video
  Video.create!(title: "The Big Bang Theory", description: "Nerds live next door to a cute girl")
end
