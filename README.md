# Tech Events Ireland - [techevents.ie](http://www.techevents.ie)

Tech Events Ireland was built over 3 years ago as one of my first Ruby on Rails applications. Since it's then it has been very infrequently maintained. The site has great potential of becoming a central hub to let the tech community know of up coming events in their area.

As the current live site was built over 3 years ago, we're starting a fresh. Once this project gets to a stage of functioning, we'll place it live on the [techevents.ie](http://www.techevents.ie) domain.

## Contributing

Without contributors this project won't get off the ground. We would really love for the community to come together and use their skills to help keep others up to date with up coming events in the community.

## Install the project locally

Whether you're a RoR developer with many years under your belt or you are just getting started, it's always a great idea to outline how to get the project up and running on your machine in a matter of minutes.

### Clone the repo:

![thoughtbot](https://github.s3.amazonaws.com/docs/bootcamp_3_fork.jpg)

Next, open terminal and navigate to a directory where you would like the project to live. Then clone the repo:

	git clone https://github.com/username/techevents_ie.git
	# Clones your fork of the repository into the current directory in terminal

	cd techevents_ie
	# Changes the active directory in the prompt to the newly cloned "techevents_ie" directory

### Install required gems

  bundle install

### Envoirnmental Variables

Add your envoirnmental variables. Open the file .env.sample and add your config

	# Found at https://secure.meetup.com/meetup_api/key/
	MEETUP_API_KEY=""

	# Found at https://developer.foursquare.com/
	FS_ID=""
	FS_SECRET=""

Then rename this file from .env.sample to .env

### Create the database

The project uses a Postgres database. Once you have Postgres installed you can create the databases with:

	rake db:create
	rake db:migrate

### Use foreman to run the server

Foreman is an alternative to rails server which takes all of the envoirnmental variables set in your .env file and places them in their required locations.

	gem install foreman
	foreman start

	# Your now up and running at http://0.0.0.0:5000/

### Gather latest meetup data

Import data from standard meetups, meetup.com and lanyrd

	# Import the data
	rake import_all

Bingo! You're ready to start creating pull requests.

## Licensing

This is open source software, licensed under the Eclipse Public License. See the file COPYING for details.
