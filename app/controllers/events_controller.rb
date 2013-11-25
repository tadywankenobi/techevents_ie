require 'events_import/events_import'

class EventsController < ApplicationController
	before_action :set_event, only: [:show]

	def index
		@events = Event.where("starting_at > ?", Time.now).order('starting_at asc')
		@event_months = @events.group_by { |t| t.starting_at.beginning_of_month }
	end

	def show
		if @event.venue and @event.venue_fs_id
			venue = EventsImport::Venues.new
			@photos = venue.fetch_photos @event.venue
		end
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_event
	  @event = Event.friendly.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def event_params
	  params.require(:event).permit(:booking_url, :ending_at, :information, :information_url, :price, :starting_at, :title, :source, :source_id, :venue_id)
	end
end
