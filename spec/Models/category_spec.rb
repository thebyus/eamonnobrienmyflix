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
		vid1 = Video.create!(title: "Test1", description: "Test1")
		vid2 = Video.create!(title: "Test2", description: "Test2")
		vid3 = Video.create!(title: "Test3", description: "Test3")
		cat1 = Category.create!(cat:"Test1")
		
		vid1.categories << [cat1]
		vid2.categories << [cat1]
		vid3.categories << [cat1]

		vid1.categories.should == [cat1]
		vid2.categories.should == [cat1]
		vid3.categories.should == [cat1]
	end
end
