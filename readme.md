# Installation of Vagrant Base #

1. Download the zipfile of this repository
2. Extract the repository somewhere
3. cd into the new directory
4. write command: "vagrant up". The vagrant environment will now be installed. 
5. enter the new virtual environment by writeing the command: "vagrant ssh"

## Directories ##
- www (this is the webroot. This is where you put your sites)
- scripts (custom scripts folder)
  -- apacheconf (this is where you will put your apache configurations. See example.conf)
- db (db dumps to be imported. Not yet implemented)


## Installation of a new site ##
1. Copy the scripts/apacheconf/example.conf to mynewsite.conf
2. Edit mynewsite.conf and replace all references to "example" with "mynewsite"
3. Download your wp install to the corresponding folder in mynewsite.conf under the www folder. Fex www/mynewsite
4. Write command "vagrant halt" and "vagrant up --provision"
5. Connect with fex mysql workbench and create a new database for the site. (See db connection section)
6. Edit your /etc/hosts file (root) and add: 192.168.33.10  mynewsite.dev
7. Browse to mynewsite.dev and hopefully it will work

## DB Connection ##
For mysql workbench, use:
SSH Hostname: 192.168.33.20:22
SSH Username: vagrant
Mysql Hostname: localhost
Mysql Server Port: 3306
Username: root

When connecting passwords are: vagrant and root


