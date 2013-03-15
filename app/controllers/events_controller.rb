require 'events_import/pub_standards'

class EventsController < ApplicationController	
	def index
		@events = Event.where("starting_at > ?", Time.now)
		@event_months = @events.group_by { |t| t.starting_at.beginning_of_month }
	end

	def show
		@event = Event.find(params[:id])
	end
end
