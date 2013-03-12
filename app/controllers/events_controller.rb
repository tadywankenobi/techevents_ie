require 'events_import/pub_standards'

class EventsController < ApplicationController	
	def index
		@events = Event.all
		pub_standards = EventsImport::PubStandards.new
		pub_standards.import(1.year.ago.to_date, Date.today)
	end
end
