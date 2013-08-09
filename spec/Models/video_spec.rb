require 'spec_helper'

describe Video do
	it {should have_many(:categories).through(:video_categories)}
	it {should validate_presence_of(:title) }
	it {should validate_presence_of(:description) }
end

describe Video do
	describe "#search_by_title" do
		it "returns nil if the search finds no match" do
			video.search_by_title
		end
		it "returns one if the search finds one match"
		it "returns as many matches as the search finds"

	
end


