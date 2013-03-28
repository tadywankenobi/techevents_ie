module EventsHelper
	def friendly_time(time_to_convert)
		time_to_convert.strftime('%e %b, %Y - %l:%M%P')
	end
end
