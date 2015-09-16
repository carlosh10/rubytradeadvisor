class Search::Pagination
  attr_accessor :total_pages, :page, :count

  def initialize total_pages = 0, page = 0, count = 0
  	self.total_pages = total_pages || 0
  	self.page = page || 0
  	self.count = count || 0
  end

end