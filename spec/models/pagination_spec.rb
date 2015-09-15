require 'rails_helper'

RSpec.describe Search::Pagination, type: :model do

    it "cannot set nil on contructor" do
    	pagination = Search::Pagination.new(nil, nil, nil)
    	expect(pagination.total_pages).to eq(0)
    	expect(pagination.count).to eq(0)
    	expect(pagination.page).to eq(0)
	end

end
