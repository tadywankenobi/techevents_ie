![thoughtbot](http://techevents.ie/images/logo.png)

# Tech Events Ireland - [techevents.ie](http://www.techevents.ie)

Tech Events Ireland was built over 3 years ago as one of my first Ruby on Rails applications. Since it's then it has been very infrequently maintained. The site has great potential of becoming a central hub to let the tech community know of up coming events in their area.

As the current live site was built over 3 years ago, we're starting a fresh. Once this project gets to a stage of functioning, we'll place it live on the [techevents.ie](http://www.techevents.ie) domain.

## Contributing

Without contributors this project won't get off the ground. We would really love for the community to come together and use their skills to help keep others up to date with up coming events in the community.

## Install the project locally

Whether you're a RoR developer with many years under your belt or you are just getting started, it's always a great idea to outline how to get the project up and running on your machine in a matter of minutes.

Firstly clone the repo to your GitHub account:

![thoughtbot](https://github.s3.amazonaws.com/docs/bootcamp_3_fork.jpg)

Next, open terminal and navigate to a directory where you would like the project to live. Then clone the repo:

	git clone https://github.com/username/techevents_ie.git
	# Clones your fork of the repository into the current directory in terminal

Navigate into the directory and add the orginal repo as an upstream remote. When a repository is cloned, it has a default remote called origin that points to your fork on GitHub, not the original repository it was forked from. To keep track of the original repository, you need to add another remote named upstream:

	cd techevents_ie
	# Changes the active directory in the prompt to the newly cloned "techevents_ie" directory

	git remote add upstream https://github.com/bkenny/techevents_ie.git
	# Assigns the original repository to a remote called "upstream"

	git fetch upstream
	# Pulls in changes not present in your local repository, without modifying your files

The project uses a Postgres database. Once you have Postgres installed you can create the databases with:

	rake db:create
	rake db:migrate

Then start the local server

	rails s

Import data from standard meetups, meetup.com and lanyrd

	# Add an envoirnment var for the meetup api key
	export MEETUP_API_KEY="your_meetup_com_api_key"

	# Import the data
	rake import_all

Bingo! You're ready to start creating pull requests.

## Licensing

This is open source software, licensed under the Eclipse Public License. See the file COPYING for details.
