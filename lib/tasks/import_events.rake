require 'events_import/events_import'
require 'carmen'
include Carmen

task :import_meetups => :environment do
	puts "Importing Pub Standards Meetups..."
  pub_standards = EventsImport::Meetups::PubStandards.new
  pub_standards.import(1.year.ago.to_date, Date.today + 6.months)
  puts "Done."

  puts "Importing X-Cake Meetups..."
  xcake = EventsImport::Meetups::Xcake.new
	xcake.import(1.year.ago.to_date, Date.today + 6.months)
	puts "Done."
end

task :import_providers => :environment do
	puts "Importing Meetup.com..."
	meetup = EventsImport::Providers::Meetup.new
	lanyrd = EventsImport::Providers::Lanyrd.new

	ie = Country.named('Ireland')
	ie.subregions.each do |province|
		province.subregions.each do |county|
			puts "Checking #{county.name}, #{ie.alpha_2_code} for meetups and lanyrds"
			meetup.update(ie.alpha_2_code, province.name, county.name)
			lanyrd.update county
		end
	end
	puts "Done."
end

task :import_all => :environment do
	Rake::Task['import_meetups'].invoke
	Rake::Task['import_providers'].invoke
end