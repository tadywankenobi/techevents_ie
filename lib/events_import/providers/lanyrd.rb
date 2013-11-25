include Lanyrd
require 'yaml'
require 'json'

module EventsImport
	module Providers
		class Lanyrd

			def update county
				topics = fetch_topics
				lanyrd = Lanyrd::Client.new

				topics.each do |topic|
					results = fetch_events(topic, county)
					results.each do |result|
						if result['external']
							slug = result['external'].gsub('http://lanyrd.com/2013/', '')[0..-2]
							fetch_event(slug)
						end
					end
				end
			end

			def fetch_topics
				topics_file = 'lib/events_import/providers/lanyrd_topics.yaml'
				YAML::load(File.open(topics_file))
			end

			def fetch_events(topic, county)
				lanyrd = Lanyrd::Client.new
				lanyrd.search("#{topic} #{county}")
			end

			def fetch_event(slug)
				lanyrd = Lanyrd::Client.new
				event = lanyrd.event(slug)
				check_or_create(event)
			end

			def check_or_create(event)
				puts "Checking or creating #{event['title']}"

				if event['primary_venue']
					venue = Venue.where(title: event['primary_venue']['title'], county: event['primary_venue']['combined_place'].split(", ").first).first_or_create(
						title: event['primary_venue']['title'],
						address: event['primary_venue']['subtitle'],
						county: event['primary_venue']['combined_place'].split(", ").first,
						country: event['primary_venue']['combined_place'].split(", ").last,
						lat: event['primary_venue']['latitude'],
						lng: event['primary_venue']['longitude']
					)
					puts "Venue: #{venue.title}"

					unless venue.fs_id
						venue_import = EventsImport::Venues.new
						venue_import.fetch_fs_id venue
					end
				end

				if venue
					venue_id = venue.id
				else
					venue_id = 0
				end

				Event.where(source: "lanyrd", source_id: event['external']).first_or_create(
					title: event['title'],
					starting_at: DateTime.parse(event['start_date']).change({hour: 9, min: 00}),
					ending_at: DateTime.parse(event['end_date']).change({hour: 18, min: 00}),
					information_url: event['external'],
					information: event['tagline'],
					source: 'lanyrd',
					source_id: event['external'],
					venue_id: venue_id
				)
			end

		end
	end
end