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
end
