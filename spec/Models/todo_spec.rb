require 'spec_helper'

describe Video do 
	it "saves itself"	 do
		video = Video.new(title:"Life of Pi", description: "Based on Yann Martel's best-selling novel, this coming-of-age tale recounts the adventures of Pi, an Indian boy who is the sole survivor of a shipwreck. Pi finds himself on a lifeboat with only some zoo animals for company.

")
		video.save
		Video.first.title.should == "Life of Pi"

	end
end