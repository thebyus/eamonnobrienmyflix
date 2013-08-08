require 'spec_helper'

describe Video do 
	it "saves itself"	 do
		video = Video.new(
			title:"Test",
			description: "Testing",
			small_cover_url: "Test_small",
			big_cover_url: "Test_big")
		video.save
		Video.first.title.should == "Test"
	end
end

describe Video do
	it "belongs to a category" do
		Category.create!(cat:"Test")
		vid = Video.create!(title: "Test2")
		vid.categories << Category.first
		vid.categories.should =="Test"
	end
end