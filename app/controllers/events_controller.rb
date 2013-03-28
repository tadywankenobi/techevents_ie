require 'events_import/events_import'

class EventsController < ApplicationController
	def index
		@events = Event.where("starting_at > ?", Time.now).order('starting_at asc')
		@event_months = @events.group_by { |t| t.starting_at.beginning_of_month }
	end

	def show
		@event = Event.find(params[:id])

		if @event.venue.fs_id?
			venue = EventsImport::Venues.new
			@photos = venue.fetch_photos @event.venue
		end
	end
end
