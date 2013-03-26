include Lanyrd
require 'yaml'

module EventsImport
	module Providers
		class Lanyrd

			def update
				topics = fetch_topics
				lanyrd = Lanyrd::Client.new
				
				topics.each do |topic|
					results = fetch_events(topic, 'Dublin')
					results['sections'].each do |section|
						section['rows'].each do |event|
							slug = event['external'].gsub('http://lanyrd.com/2013/', '')[0..-2]
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
				Event.where(:source => "lanyrd", :source_id => event['external']).first_or_create(
					:title => event['title'],
					:starting_at => DateTime.parse(event['start_date']).change({:hour => 9, :min => 00}),
					:ending_at => DateTime.parse(event['end_date']).change({:hour => 18, :min => 00}),
					:information_url => event['external'],
					:information => event['tagline'],
					:source => 'lanyrd',
					:source_id => event['external']
				)
			end

		end
	end
end