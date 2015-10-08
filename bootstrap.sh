#!/bin/bash

webdirectory=www
scriptsdirectory=scripts
dbdirectory=db

exampleconf=/vagrant/"$scriptsdirectory"/apacheconf/example.conf
examplebedrockconf=/vagrant/"$scriptsdirectory"/apacheconf/example_bedrock.conf

config_count=0

sudo apt-get update
sudo apt-get install -y unzip

#############################
# Create directories needed #
#############################

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
		if [[ "$filename" != "$exampleconf" && "$filename" != "$examplebedrockconf" ]]; then

			echo "Copying $filename to /etc/apache2/sites-available/"
    	sudo cp "$filename" /etc/apache2/sites-available/
    		
    	filename_without_path=$(basename $filename)
    	filename_without_ext="${filename_without_path%.*}"

    	echo "Enabling the site on apache server"
    	a2ensite "$filename_without_ext"

    	config_count=$[config_count + 1]

    fi
    
	done
fi


###############################################################
# Reload the apache config if there are new virtualhosts      #
###############################################################
if [ "$config_count" -gt "0" ]; then
	echo "Reloading apache configuration"
	sudo service apache2 reload
fi


#####################
# Install WP-CLI    #
#####################
if [ ! -f /usr/local/bin/wp ]; then
	echo "Fetching WP-CLI"
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	echo "Installign WP-CLI"
	chmod +x wp-cli.phar
	sudo mv wp-cli.phar /usr/local/bin/wp
	echo "WP-CLI installation done. Use wp on commandline"
	wp --info
fi


#######################
# Install Composer    #
#######################
if [ ! -f /usr/local/bin/composer ]; then
	echo "Installing composer"
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
fi


#######################
# Install nodejs      #
# Need to be added	  #
# like this since     #
# apt version does    #
# not work            #
#######################
if [ ! -f /usr/bin/npm ]; then
	echo "Installing nodejs and npm"
	curl -sL https://deb.nodesource.com/setup | sudo bash -
	sudo apt-get install -y nodejs

	echo "Updating npm installation"
	sudo npm install npm -g
fi

#######################
# Install grunt       #
#######################
if [ ! -f /usr/bin/grunt ]; then
	echo "Installing grunt"
	sudo npm install -g grunt-cli
fi


#######################
# Install SASS        #
#######################
if [ ! -f /opt/vagrant_ruby/bin/sass ]; then
	echo "Installing sass"
	gem install sass
fi


#######################
# Install bower       #
#######################
if [ ! -f /usr/bin/bower ]; then
	echo "Installing bower"
	sudo npm install -g bower
fi


#######################
# Install gulp        #
#######################
if [ ! -f /usr/bin/gulp ]; then
	echo "Installing gulp"
	sudo npm install -g gulp
fi


#####################################################################
# Install new command for creating roots/bedrock sites              #
#####################################################################
if [ -f /usr/local/bin/create-bedrock-project ]; then
	echo "Installing new command for creating bedrock projects"
	sudo rm /usr/local/bin/create-bedrock-project
fi

if [ -f /vagrant/"$scriptsdirectory"/commands/create-bedrock-project.sh ]; then
	sudo cp /vagrant/"$scriptsdirectory"/commands/create-bedrock-project.sh /usr/local/bin/create-bedrock-project
	sudo chown vagrant:vagrant /usr/local/bin/create-bedrock-project
	sudo chmod a+x /usr/local/bin/create-bedrock-project
fi


#####################################################################
# Install new command for importing databases                       #
#####################################################################
if [ -f /usr/local/bin/import-database ]; then
	echo "Installing new command for importing databases"
	sudo rm /usr/local/bin/import-database
fi

if [ -f /vagrant/"$scriptsdirectory"/commands/import-database.sh ]; then
	sudo cp /vagrant/"$scriptsdirectory"/commands/import-database.sh /usr/local/bin/import-database
	sudo chown vagrant:vagrant /usr/local/bin/import-database
	sudo chmod a+x /usr/local/bin/import-database
fi

#####################################################################
# PHP Config   																	                    #
#####################################################################
sed -i "s/post_max_size = .*/post_max_size = 500M/" /etc/php5/apache2/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 500M/" /etc/php5/apache2/php.ini
sudo service apache2 restart

#######################
# DONE                #
#######################
echo "Provisioning done!"

