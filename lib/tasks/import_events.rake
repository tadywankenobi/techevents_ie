require 'events_import/events_import'
include Carmen

task :import_meetups => :environment do
  pub_standards = EventsImport::Meetups::PubStandards.new
  pub_standards.import(1.year.ago.to_date, Date.today + 6.months)

  xcake = EventsImport::Meetups::Xcake.new
	xcake.import(1.year.ago.to_date, Date.today + 6.months)
end

task :import_providers => :environment do
	meetup = EventsImport::Providers::Meetup.new

	ie = Country.named('Ireland')
	ie.subregions.each do |province|
		province.subregions.each do |county|
			puts "Checking #{county.name}, #{ie.alpha_2_code} for meetups"
			meetup.update(ie.alpha_2_code, province.name, county.name)
		end
	end
end

task :import_lanyrd => :environment do
	lanyrd = EventsImport::Providers::Lanyrd.new
	lanyrd.update
end