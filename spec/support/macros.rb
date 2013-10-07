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
  @cosby = Video.create!(title: "The Cosby Show", description: "NYC mom and dad struggle to raise their children", created_at: 1.day.ago)
end

def create_big_bang_video
  @big_bang = Video.create!(title: "The Big Bang Theory", description: "Nerds live next door to a cute girl")
end

def sign_in(a_user=nil)
    user = a_user || Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end

def sign_out
  visit sign_out_path
end
