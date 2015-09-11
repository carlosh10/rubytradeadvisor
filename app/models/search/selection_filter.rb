class Search::SelectionFilter

  attr_accessor :selected, :hits, :value, :type

  def initialize value, hits, selected = false, type = nil
    self.value = value
    self.hits =  hits
    self.selected = selected
    self.type = type
  end

end
