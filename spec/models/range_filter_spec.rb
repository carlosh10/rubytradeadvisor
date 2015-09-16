require 'rails_helper'

RSpec.describe Search::RangeFilter, type: :model do
      
	  it "initialize range filter" do

    	pagination = Search::RangeFilter.new(1,5,1,5,Search::RangeFilterType::UnityValue)
		
		expect(pagination.min).to eq(1)
		expect(pagination.max).to eq(5)
		expect(pagination.min_range).to eq(1)
		expect(pagination.max_range).to eq(5)
		expect(pagination.type).to eq(Search::RangeFilterType::UnityValue)
	end
	
    it "range filter test hash build return" do
    	pagination = Search::RangeFilter.new(1,5,1,5,Search::RangeFilterType::UnityValue)
		
		expect(pagination.build).to eq({:range=>{"UnityValue"=>{:gte=>"1", :lte=>"5"}}})
	end
	
end
