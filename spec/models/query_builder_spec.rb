require 'rails_helper'

RSpec.describe Search::QueryBuilder, type: :model do
     
    it "should has a struct" do
    	builder = Search::QueryBuilder.new
    	expect(builder.struct).to be_kind_of(Hash)
    	expect(builder.struct).to_not be_nil
	end

	it "should has a struct with aggregations of range_filters" do
    	builder = Search::QueryBuilder.new

    	Search::RangeFilterType.constants.each do |type|
    		expect(builder.struct[:body][:aggs][type]).to_not be_nil
    		expect(builder.struct[:body][:aggs][type]).to be_kind_of(Hash)
    		expect(builder.struct[:body][:aggs][type][:max][:field]).to eq(builder.index_of[type])
    	end

	end

	it "should has a struct with aggregations of selection_filters" do
    	builder = Search::QueryBuilder.new

    	Search::SelectionFilterType.constants.each do |type|
    		expect(builder.struct[:body][:aggs][type]).to_not be_nil
    		expect(builder.struct[:body][:aggs][type]).to be_kind_of(Hash)
    		expect(builder.struct[:body][:aggs][type][:terms][:field]).to eq(builder.index_of[type])
    	end
	end

	it "should has a hash of elasticsearch indexes" do
    	builder = Search::QueryBuilder.new
    	expect(builder.index_of).to be_kind_of(Hash)
    	expect(builder.index_of).to_not be_nil
	end

	it "should has a hash of elasticsearch indexes of all range_filters" do
    	builder = Search::QueryBuilder.new
    	Search::RangeFilterType.constants.each do |type|
    		expect(builder.index_of[type]).to_not be_nil
    		expect(builder.index_of[type]).to be_kind_of(Symbol)
    	end
	end

	it "should has a hash of elasticsearch indexes of all selection_filters" do
    	builder = Search::QueryBuilder.new
    	Search::SelectionFilterType.constants.each do |type|
    		expect(builder.index_of[type]).to_not be_nil
    		expect(builder.index_of[type]).to be_kind_of(Symbol)
    	end
	end

	it "build should mount a query with multi terms" do
    	builder = Search::QueryBuilder.new
    	builder.build("caneta azul")
   
	end

end
