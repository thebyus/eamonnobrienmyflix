require 'spec_helper'

describe VideosController do
  describe "GET show" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "sets the @video variable" do
        vid = Video.create!(title: "Argo", description: "Get Americans out of Iran in the '70's")
#        vid = Fabricate(:video)

        get :show, id: vid.id
        expect(assigns(:video)).to eq(vid)
      end
      it "renders the show page template"
    end
  end
end