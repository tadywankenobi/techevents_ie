require 'events_import/pub_standards'

class EventsController < ApplicationController	
	def index
		@events = Event.all
	end
end
