class Search::Pagination
  attr_accessor :total_pages, :page, :count

  def initialize total_pages = 0, page = 0, count = 0
  	self.total_pages = total_pages
  	self.page = page
  	self.count = count
  end

end