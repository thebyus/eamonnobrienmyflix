require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      adam = Fabricate(:user)
      set_current_user(adam)
      queue_item1 = Fabricate(:queue_item, user: adam)
      queue_item2 = Fabricate(:queue_item, user: adam)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index}
    end
  end

  describe "POST create" do
    it "redirects to the my_queue page" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates the queue item that is associated with the video" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the signed in user" do
      adam = Fabricate(:user)
      set_current_user(adam)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(adam)
    end

    it "puts the video as the last one in the queue" do
      adam = Fabricate(:user)
      set_current_user(adam)
      argo = Fabricate(:video)
      Fabricate(:queue_item, video: argo, user: adam)
      flight = Fabricate(:video)
      post :create, video_id: flight.id
      flight_queue_item = QueueItem.where(video_id:flight.id, user_id: adam.id).first
      expect(flight_queue_item.position).to eq(2)
    end

    it "does not add the video if the video is already in the queue" do
      adam = Fabricate(:user)
      set_current_user(adam)
      argo = Fabricate(:video)
      Fabricate(:queue_item, video: argo, user: adam)
      post :create, video_id: argo.id
      expect(adam.queue_items.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 3 }
    end
  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      adam = Fabricate(:user)
      set_current_user(adam)
      queue_item = Fabricate(:queue_item, user: adam)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "does not allow current user to delete queue item if not in current_user's queue" do
      adam = Fabricate(:user)
      bill = Fabricate(:user)
      set_current_user(adam)
      queue_item = Fabricate(:queue_item, user: bill)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to the sign in page for unauthenticated users" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 3 }
    end

    it "normalizes queue item position" do
      adam = Fabricate(:user)
      set_current_user(adam)
      queue_item1 = Fabricate(:queue_item, user: adam, position: 1)
      queue_item2 = Fabricate(:queue_item, user: adam, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end
  end

  describe "POST update_queue" do

    it_behaves_like "requires sign in" do
      let(:action) do
        post :update_queue, queue_items: [ {id:2, position: 3}, {id: 1, position: 2} ]
      end
    end

    context "with valid input" do

      let(:adam) { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: adam, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: adam, position: 2) }

      before { set_current_user(adam) }

      it "redirects to the my_queue page" do
        post :update_queue, queue_items: [ {id:queue_item1.id, position: 2}, {id: queue_item2.id, position: 1} ]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue items" do
        post :update_queue, queue_items: [ {id:queue_item1.id, position: 2}, {id: queue_item2.id, position: 1} ]
        expect(adam.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [ {id:queue_item1.id, position: 3}, {id: queue_item2.id, position: 2} ]
        expect(adam.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid input" do

      let(:adam) { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: adam, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: adam, position: 2) }

      before { set_current_user(adam) }

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [ {id:queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2} ]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash error message" do
        post :update_queue, queue_items: [ {id:queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2} ]
        expect(flash[:error]).to be_present
      end

      it "does not change the position " do
        post :update_queue, queue_items: [ {id:queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1} ]
        expect(queue_item1.reload.position).to eq(3)
      end
    end

    context "with queue items that don't belong to the current user" do
      it "does not change the order" do
        adam = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(adam)
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_item2 = Fabricate(:queue_item, user: adam, position: 2)
        post :update_queue, queue_items: [ {id:queue_item1.id, position: 3}, {id: queue_item2.id, position: 2} ]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end
end
