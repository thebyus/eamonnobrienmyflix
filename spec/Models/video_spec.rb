require 'spec_helper'

describe Video do 
	it "saves itself"	 do
		video = Video.new(title:"Test", description: "Testing")
		video.save
		Video.first.title.should == "Test"
	end
end

describe Video do
	it "belongs to category" do
		Category.create(cat:"Test")
		video = Video.first
		video.category << Category.first
		Video.category.should =="Test"

	end
end