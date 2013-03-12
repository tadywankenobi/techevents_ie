require 'events_import/pub_standards'

task :import_events => :environment do
  pub_standards = EventsImport::PubStandards.new
  pub_standards.import(1.year.ago.to_date, Date.today + 6.months)
end