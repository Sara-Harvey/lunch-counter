class Restaurant < ActiveRecord::Base
	has_many :sandwiches
end