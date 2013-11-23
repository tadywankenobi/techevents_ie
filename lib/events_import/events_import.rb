require 'events_import/meetups/pub_standards'
require 'events_import/meetups/xcake'

require 'events_import/providers/meetup'
require 'events_import/providers/lanyrd'

module EventsImport
	class Venues

		@@client = Foursquare2::Client.new(client_id: ENV['FS_ID'], client_secret: ENV['FS_SECRET'])

		def fetch_fs_id venue
			fs_venue = Hashie::Mash.new(@@client.search_venues(ll: "#{venue.lat},#{venue.lng}", query: venue.title)).groups.first.items.first
			if fs_venue
				venue.fs_id = fs_venue.id
				venue.save
			end
		end

		def fetch_photos venue
			Hashie::Mash.new(@@client.venue_photos(venue.fs_id, options = {group: 'venue'})).items
		end
	end
end