require 'spec_helper'

describe User  do
  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }
  it { should validate_presence_of (:full_name) }
  it { should validate_uniqueness_of (:email) }
  it { should have_many(:queue_items) }
  it { should have_many(:reviews)}

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:user) }
  end

  describe "#queued_video?" do
    it "returns true when the user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video:video)
      user.queued_video?(video).should be_true
    end

    it "returns false when the user hasn't queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      user.queued_video?(video).should be_false
    end
  end

  describe "#follows?" do
    it "returns true if the current user has a following relationship with another user" do
      adam = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: adam)
      expect(adam.follows?(bob)).to be_true
    end

    it "returns false if the current user does not have a following relationship with another user" do
      adam = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: adam, follower: bob)
      expect(adam.follows?(bob)).to be_false
    end
  end

  describe "#follow" do
    it "follows another user" do
      adam = Fabricate(:user)
      bob = Fabricate(:user)
      adam.follow(bob)
      expect(adam.follows?(bob)).to be_true
    end

    it "does not follow ones self" do
      adam = Fabricate(:user)
      adam.follow(adam)
      expect(adam.follows?(adam)).to be_false
    end
  end

  describe "deactivate!" do
    it "deactivates an active user" do
      adam = Fabricate(:user, active: true)
      adam.deactivate!
      expect(adam).not_to be_active
    end
  end
end
