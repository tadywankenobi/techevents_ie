class Venue < ActiveRecord::Base
	has_many :events
	
  attr_accessible :address, :country, :county, :lat, :lng, :title
end
