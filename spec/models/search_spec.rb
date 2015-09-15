require 'rails_helper'

RSpec.describe Search, type: :model do
    
    it "get search query" do
    	search = Search.create!(query: :iphone)
    	expect(search.query).to eq("iphone")
	end

	 it "get search query with lowercase" do
    	search = Search.create!(query: :iPhone)
    	expect(search.query).to eq("iphone")
	end

	it "filters is an array" do
    	search = Search.create!(query: :iPhone)
    	expect(search.filters).to be_kind_of(Array)
    	expect(search.filters.count).to eq(0)
	end
	
end
