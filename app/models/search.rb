class Search < ActiveRecord::Base

  belongs_to :user
  attr_accessor :filters

  after_initialize do
  	self.filters = Array.new
  end

end
