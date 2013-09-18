require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets the @relationships to the current user's following relationships" do
      adam = Fabricate(:user)
      set_current_user(adam)
      bill = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: adam, leader: bill)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index}
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 4 }
    end

    it "redirects to the people page" do
      adam = Fabricate(:user)
      set_current_user(adam)
      bill = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bill, follower: adam)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end

    it "deletes the relationship if the current user is the follower" do
      adam = Fabricate(:user)
      set_current_user(adam)
      bill = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bill, follower: adam)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end

    it "does not delete the relationship if the current user is not the follower" do
      adam = Fabricate(:user)
      set_current_user(adam)
      bill = Fabricate(:user)
      chuck = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bill, follower: chuck)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create, leader_id: 3 }
    end
    it "redirects to the people page" do
      adam = Fabricate(:user)
      set_current_user(adam)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(response).to redirect_to people_path
    end

    it "creates a relationship where the current user follows the leader" do
      adam = Fabricate(:user)
      set_current_user(adam)
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(adam.following_relationships.first.leader).to eq(bob)
    end

    it "it does not create a relationship if the current user already follows the leader" do
      adam = Fabricate(:user)
      set_current_user(adam)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: adam)
      post :create, leader_id: bob.id
      expect(Relationship.count).to eq(1)
    end

    it "does not allow current user to follow themselves"
  end
end
