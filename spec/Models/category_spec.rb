require 'spec_helper'

describe Category do 
	it "saves itself"	 do
		cat = Category.new(cat:"Test")
		cat.save
		Category.first.cat.should == "Test"

	end
end