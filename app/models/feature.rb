class Feature < ActiveRecord::Base
	has_many :plans_features
	has_many :plans, :through => :plans_features
end
