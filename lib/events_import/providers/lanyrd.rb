include Lanyrd

module EventsImport
	module Providers
		class Lanyrd

			def update
				lanyrd = Lanyrd::Client.new
				results = lanyrd.search('Development Dublin')
				results['sections'].each do |section|
					section['rows'].each do |event|
						slug = event['external'].gsub('http://lanyrd.com/2013/', '')[0..-2]
						fetch_event(slug)
					end
				end
			end

			def fetch_event(slug)
				lanyrd = Lanyrd::Client.new
				event = lanyrd.event(slug)
				check_or_create(event)
			end

			def check_or_create(event)
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