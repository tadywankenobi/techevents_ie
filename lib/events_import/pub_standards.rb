module EventsImport
	class PubStandards
		def import(date_from, date_to)
			second_thursdays = (date_from..date_to).select {|d| d.wday == 4 and d.day > 7 and d.day < 15}
			second_thursdays.each{|event_date| check_or_create event_date.to_datetime}
		end

		def check_or_create event_date
			event = Event.where(:source => "pub_standards", :starting_at => event_date.beginning_of_day..event_date.end_of_day)
			unless event.count > 0
				event = Event.new(
					:title => "Pub Standards",
					:starting_at => event_date.change({:hour => 18, :min => 30}),
					:ending_at => event_date.change({:hour => 22}),
					:information_url => "http://pubstandards.ie/",
					:information => "<h3>What is it?</h3><p>Pub Standards Dublin is the largest monthly meetup of developers, designers, founders and people-who-like-to-build-stuff, in Ireland. It has been running in London and other cities since 2005, and in Dublin since August 2010.</p><p>Pub Standards is organised by Eamon Leonard & Ross Duggan of Engine Yard.</p><h3>Who is it for?</h3><p>Pub Standards is open to everyone. It's loosely aimed at web` design & development geeks, but that doesn't mean chitchat need necessarily be work-related.  Don't expect structure, don't expect presentations, just relax with likeminded people and a few beers.</p>",
					:source => "pub_standards"
				)
				event.save
			end
		end

	end
end