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
	it "can belong to many categories" do
		cat1 = Category.create!(cat:"Test")
		cat2 = Category.create!(cat: "Test2")
		vid = Video.create!(title: "Test2")
		vid.categories << [cat1, cat2]
		vid.categories.size.should == 2
	end
end