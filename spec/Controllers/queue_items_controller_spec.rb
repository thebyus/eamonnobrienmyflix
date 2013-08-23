require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      adam = Fabricate(:user)
      session[:user_id] = adam.id
      queue_item1 = Fabricate(:queue_item, user: adam)
      queue_item2 = Fabricate(:queue_item, user: adam)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "should redirect to the sign in page for unathenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    it "redirects to the my_queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates the queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the signed in user" do
      adam = Fabricate(:user)
      session[:user_id] = adam.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(adam)
    end

    it "puts the video as the last one in the queue" do
      adam = Fabricate(:user)
      session[:user_id] = adam.id
      argo = Fabricate(:video)
      Fabricate(:queue_item, video: argo, user: adam)
      flight = Fabricate(:video)
      post :create, video_id: flight.id
      flight_queue_item = QueueItem.where(video_id:flight.id, user_id: adam.id).first
      expect(flight_queue_item.position).to eq(2)
    end

    it "does not add the video if the video is already in the queue" do
      adam = Fabricate(:user)
      session[:user_id] = adam.id
      argo = Fabricate(:video)
      Fabricate(:queue_item, video: argo, user: adam)
      post :create, video_id: argo.id
      expect(adam.queue_items.count).to eq(1)
    end

    it "redirects to sign_in page for unathenticated user" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end
end
