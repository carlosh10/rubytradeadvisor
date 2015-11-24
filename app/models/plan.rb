class Plan < ActiveRecord::Base
	has_many :plans_features
	has_many :features, :through => :plans_features
end
