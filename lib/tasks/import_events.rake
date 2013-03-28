require 'events_import/events_import'
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

	ie = Country.named('Ireland')
	ie.subregions.each do |province|
		province.subregions.each do |county|
			puts "Checking #{county.name}, #{ie.alpha_2_code} for meetups"
			meetup.update(ie.alpha_2_code, province.name, county.name)
		end
	end
	puts "Done."

	#puts "Importing Lanyard..."
	#lanyrd = EventsImport::Providers::Lanyrd.new
	#lanyrd.update
	#puts "Done."
end

task :import_all => :environment do
	Rake::Task['import_meetups'].invoke
	Rake::Task['import_providers'].invoke
end