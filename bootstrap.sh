#!/bin/bash

webdirectory=www
scriptsdirectory=scripts
dbdirectory=db

exampleconf=/vagrant/"$scriptsdirectory"/apacheconf/example.conf


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

###########################################################################
# Copy all virtualhosts to apache's sites directory and activate the site #
###########################################################################
if [ -d /vagrant/"$scriptsdirectory"/apacheconf ]; then
	for filename in /vagrant/"$scriptsdirectory"/apacheconf/*.conf; do

		# No need to copy the example conf file
		if [ "$filename" != "$exampleconf" ]; then

			echo "Copying $filename to /etc/apache2/sites-available/"
    		sudo cp "$filename" /etc/apache2/sites-available/
    		
    		filename_without_path=$(basename $filename)
    		filename_without_ext="${filename_without_path%.*}"

    		echo "Enabling the site on apache server"
    		a2ensite "$filename_without_ext"

    	fi

	done
fi

echo "Reloading apache configuration"
sudo service apache2 reload

#####################
# Install WP-CLI    #
#####################
echo "Fetching WP-CLI"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
echo "Installign WP-CLI"
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
echo "WP-CLI installation done. Use wp on commandline"
wp --info


#######################
# Install Composer    #
#######################
echo "Installing composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo "Composer installed"


#######################
# Install nodejs      #
#######################
echo "Installing nodejs"
sudo apt-get -y install nodejs


#######################
# Install npm         #
#######################
echo "Installing node package manager"
sudo apt-get -y install npm


#######################
# DONE                #
#######################
echo "Provisioning done!"

