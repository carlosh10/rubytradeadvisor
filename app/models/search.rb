class Search < ActiveRecord::Base

  belongs_to :user
  attr_accessor :filters, :cif_total

  after_initialize do
  	self.filters = Array.new
  end

end
