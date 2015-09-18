require 'rails_helper'

include Search::RangeFilterType

RSpec.describe Search::QueryBuilder, type: :model do
    
    it "should has a struct" do
    	builder = Search::QueryBuilder.new
    	expect(builder.struct).to be_kind_of(Hash)
    	expect(builder.struct).to_not be_nil
	end

end
