class Search::SelectionFilter

  include Filter
  attr_accessor :selected, :hits, :value, :type

  def initialize value, hits, selected = false, type = Filter::FilterType::Ncm
    self.value = value
    self.hits =  hits
    self.selected = selected
    self.type = type
  end

end
