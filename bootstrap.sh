#!/bin/bash

webdirectory=www
scriptsdirectory=scripts
dbdirectory=db

# Create the forlder for the websites
if [ ! -d /vagrant/"$webdirectory" ]; then
	mkdir /vagrant/"$webdirectory"
fi

# Create the forlder for custom scripts
if [ ! -d /vagrant/"$scriptsdirectory" ]; then
	mkdir /vagrant/"$scriptsdirectory"
fi

# Create the forlder for custom scripts
if [ ! -d /vagrant/"$scriptsdirectory"/apacheconf ]; then
	mkdir /vagrant/"$scriptsdirectory"/apacheconf
fi

# Create the folder for db dumps
if [ ! -d /vagrant/"$dbdirectory" ]; then
	mkdir /vagrant/"$dbdirectory"
fi

# Copy all virtualhosts to apache's sites directory and activate the site
if [ -d /vagrant/"$scriptsdirectory"/apacheconf ]; then
	for filename in /vagrant/"$scriptsdirectory"/apacheconf/*.conf; do
    	sudo cp "$filename" /etc/apache2/sites-available/
    	a2ensite "$filename"
	done
fi