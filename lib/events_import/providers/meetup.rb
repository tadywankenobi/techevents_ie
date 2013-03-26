module EventsImport
	module Providers
		class Meetup
			# Grabs the lastest meetups from the meetup.com API
			# You'll need a meetup api key stored in an envorinment variable under MEETUP_API_KEY
			#
			# API Info URLS
			# http://www.meetup.com/meetup_api/console/?path=/2/groups
			# http://www.meetup.com/meetup_api/console/?path=/2/events

			# Base URI and the tech category for meetup.com
			@@base_uri = 'http://api.meetup.com/2/'
			@@category_id = '34'

			def update(country_code, state, city)
				groups = fetch_groups(country_code, state, city)
				unless groups.problem
					puts "Found " + groups.results.count.to_s + " groups in #{city}"
					groups.results.each do |group|
						events = fetch_events(group.id.to_s)
						puts "Found " + events.count.to_s + " events for #{group.name}"
						check_or_create events

						# Avoids throttling failure from meetup.com
						sleep 2
					end
				end
			end

			def fetch_groups(country_code, state, city)
				Hashie::Mash.new(HTTParty.get(@@base_uri + "groups?category_id=" + @@category_id + "&country=" + country_code + "&state=" + state + "&city=" + city + "&key=" + ENV['MEETUP_API_KEY']))
			end

			def fetch_events(group_id)
				search = Hashie::Mash.new(HTTParty.get(@@base_uri + "events?group_id=" + group_id + "&key=" + ENV['MEETUP_API_KEY']))
				unless search.count == 0
					events = search.results
				end
				search.results
			end

			def check_or_create events
				events.each do |event|
					starting_time = Time.at(event.time / 1000.0)
					if event.duration
						ending_time = starting_time + (event.duration / 1000.0)
					else
						ending_time = starting_time + 3.hours
					end
					Event.where(:source => "meetup", :source_id => event.id).first_or_create(
						:title => event.name,
						:starting_at => Time.at(event.time / 1000.0),
						:ending_at => ending_time,
						:information_url => event.event_url,
						:information => event.description,
						:source => "meetup"
					)
				end
			end
		end
	end
end