class Event < ActiveRecord::Base
	belongs_to :venue

	# Creates the slug for the URL
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  attr_accessible :booking_url, :ending_at, :information, :information_url, :price, :starting_at, :title, :source, :source_id, :venue_id
end
