require 'rails_helper'

include Search::RangeFilterType

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
		start = "caneta azul"
    	
		builder.build(start)
		
		should = builder.struct[:body][:query][:filtered][:filter][:bool][:should].first
		terms = should[:terms][:descricao_detalhada_produto]
		
		expect(terms).to be_kind_of(Array)
		
		terms.each do |t|
			expect(start.include? t).to be_truthy
		end
		
	end
	
	it "build should mount a pagination" do
    	builder = Search::QueryBuilder.new
		start = "caneta azul"
    	
		builder.build(start)
		pagination = builder.pagination
		
		expect(pagination.page).to eq(1)
		expect(pagination.count).to eq(36)
		expect(pagination.total_pages).to eq(0)
	end
	
	it "after build, without filter, builder must not include any select clause" do
    	builder = Search::QueryBuilder.new
		start = "caneta azul"
    	
		builder.build(start)
		
		must = builder.struct[:body][:query][:filtered][:filter][:bool][:must]
			
		expect(must).to be_kind_of(Array)
		expect(must.count).to eq(0)
	end
	
	it "after build, with range filters, builder must include select clause" do
    	builder = Search::QueryBuilder.new
		start = "caneta azul"
    	filters = [ Search::RangeFilter.new(1, 2, 3, 4, Search::RangeFilterType::TotalValue) ]
		builder.build(start, nil, filters )
		
		must = builder.struct[:body][:query][:filtered][:filter][:bool][:must]
	
		expect(must).to be_kind_of(Array)
		expect(must.count).to eq(1)
		expect(must.first).to eq({:range=>{:CIF=>{:gte=>"1", :lte=>"2"}}})
	end
	
	it "after build, with selection filters selected, builder must include select clause" do
    	builder = Search::QueryBuilder.new
		start = "caneta azul"
    	filters = [ Search::SelectionFilter.new(1, 10, true, Search::SelectionFilterType::CountryAquisition) ]
		builder.build(start, filters )
		
		must = builder.struct[:body][:query][:filtered][:filter][:bool][:must]
	
		expect(must).to be_kind_of(Array)
		expect(must.count).to eq(1)
		expect(must.first).to eq({:terms=>{:siglaPaisAquisicao=>[1]}})
	end
	
	it "after build, with selection filters not selected, builder must include select clause" do
    	builder = Search::QueryBuilder.new
		start = "caneta azul"
    	filters = [ Search::SelectionFilter.new(1, 10, false, Search::SelectionFilterType::CountryAquisition) ]
		builder.build(start, filters )
		
		must = builder.struct[:body][:query][:filtered][:filter][:bool][:must]
	
		expect(must).to be_kind_of(Array)
		expect(must.count).to eq(0)
	end
	

end
