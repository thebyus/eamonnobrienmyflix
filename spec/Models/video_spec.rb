require 'spec_helper'

describe Video do
	it {should have_many(:categories).through(:video_categories)}
	it {should validate_presence_of(:title) }
	it {should validate_presence_of(:description) }

	describe ".search_by_title" do
		it "returns empty array if the search finds no match" do
			v = "Argo"
			vid1 = Video.create!(title: v, description: "testing")
			Video.search_by_title("hello").should == []
		end

		it "returns one video if the search finds one match" do
			v = "Argo"
			vid1 = Video.create!(title: v, description: "testing")
			Video.search_by_title(v).should == [vid1]
		end
	
		it "returns as many matches as the search finds" do
			v1 = "Flight of Fancy"
			v2 = "Flight of the Navigator"
			v3 = "The Wright Brothers: the birth of flight"

			vid1 = Video.create!(title: v1, description: "testing")
			vid2 = Video.create!(title: v2, description: "testing")
			vid3 = Video.create!(title: v3, description: "testing")
			Video.search_by_title("l").should match_array {[vid1, vid2, vid3]}
		end
	end
end


