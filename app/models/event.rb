class Event < ActiveRecord::Base
	belongs_to :venue

	# Creates the slug for the URL
  extend FriendlyId
  friendly_id :title, use: :slugged

  delegate :title, :address, :full_address, :county, :lat, :lng, :fs_id, to: :venue, prefix: true
end
