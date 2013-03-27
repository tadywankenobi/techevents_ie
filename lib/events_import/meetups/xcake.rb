module EventsImport
	module Meetups
		class Xcake
			def import(date_from, date_to)
				@second_tuesdays = (date_from..date_to).select {|d| d.wday == 2 and d.day > 7 and d.day < 15}
				@second_tuesdays.each{|event_date| check_or_create event_date.to_datetime}
			end

			def check_or_create event_date
				venue = Venue.where(:title => "Science Gallery", :county => "Dublin").first_or_create(
					:title => "Science Gallery",
					:address => "Pearse St",
					:county => "Dublin",
					:country => "Ireland",
					:lat => 53.344161,
					:lng => -6.250347
				)

				Event.where(:source => "xcake", :starting_at => event_date.beginning_of_day..event_date.end_of_day).first_or_create(
					:title => "X-Cake",
					:starting_at => event_date.change({:hour => 18, :min => 15}),
					:ending_at => event_date.change({:hour => 22}),
					:information_url => "http://x-cake.ning.com/",
					:information => "<p>XCake is a monthly meetup of iOS devs in Ireland. Usually happens every month in Belfast and Dublin. Sometimes Galway too.</p>",
					:source => "xcake",
					:venue_id => venue.id
				)
			end
		end
	end
end