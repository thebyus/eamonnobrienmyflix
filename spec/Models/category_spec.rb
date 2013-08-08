require 'spec_helper'

describe Category do 
	it "saves itself"	 do
		cat = Category.new(cat:"Test")
		cat.save
		Category.first.cat.should == "Test"

	end
end

describe Category do 
	it "has many videos"	 do
		vid1 = Video.create!(title: "Test1")
		vid2 = Video.create!(title: "Test2")
		vid3 = Video.create!(title: "Test3")
		Category.create!(cat:"Test1")
		
		vid1 << Category.first
		vid2 << Category.first
		vid3 << Category.first

		Category.first.size.should == 3
	end
end
