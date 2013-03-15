require 'events_import/events_import'
require 'spec_helper'

describe EventsImport::PubStandards do
	it "finds the second thursday of every month for a range" do
		pub_standards = EventsImport::PubStandards.new
		pub_standards.import(Date.new(2012,01,01), Date.new(2012,12,31))
		expect(pub_standards.second_thursdays.count).to eq 12
	end

	it "creates an event" do
		@date = Date.new(2013,02,14)
		pub_standards = EventsImport::PubStandards.new
		@new_event = pub_standards.check_or_create @date
		@find_event = Event.where(:source => "pub_standards", :starting_at => @date.beginning_of_day..@date.end_of_day)
		expect(@find_event.count).to eq 1
	end
end