#!/bin/bash

webrootdir=/vagrant/www
apacheconfdir=/vagrant/scripts/apacheconf
apachedir=/etc/apache2/sites-available

if [ ! -d "$webrootdir"/$1 ]; then

	echo "Trying to install a new bedrock project"

	# Create the project
	composer create-project roots/bedrock "$webrootdir"/$1

	# Copy example conf file to the the new sites conf file
	cp "$apacheconfdir"/example_bedrock.conf "$apacheconfdir"/$1.conf

	# Replace all references to example with the new site name
	perl -pi -e "s/example/$1/g" "$apacheconfdir"/$1.conf

	sudo cp "$apacheconfdir"/$1.conf "$apachedir"/

	sudo a2ensite $1

	sudo service apache2 reload

	echo "Bedrock project created and installed"
fi
