class PlansFeature < ActiveRecord::Base
  belongs_to :plan
  belongs_to :feature
end
