module EventsImport
	class PubStandards
		def import(date_from, date_to)
			second_thursday = (date_from..date_to).select {|d| d.wday == 4 and d.day > 7 and d.day < 15}
			puts second_thursday
		end
	end
end