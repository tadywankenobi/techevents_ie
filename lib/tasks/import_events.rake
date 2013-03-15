require 'events_import/events_import'

task :import_events => :environment do
  pub_standards = EventsImport::Meetups::PubStandards.new
  pub_standards.import(1.year.ago.to_date, Date.today + 6.months)

  xcake = EventsImport::Meetups::Xcake.new
	xcake.import(1.year.ago.to_date, Date.today + 6.months)
end