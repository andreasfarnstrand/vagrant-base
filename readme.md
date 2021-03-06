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


## Installation of a new site (not roots/bedrock) ##
1. Copy the scripts/apacheconf/example.conf to mynewsite.conf
2. Edit mynewsite.conf and replace all references to "example" with "mynewsite"
3. Download your wp install to the corresponding folder in mynewsite.conf under the www folder. Fex www/mynewsite
4. Write command "vagrant halt" and "vagrant up --provision"
5. Connect with fex mysql workbench and create a new database for the site. (See db connection section)
6. Edit your /etc/hosts file (root) and add: 192.168.33.10  mynewsite.dev
7. Browse to mynewsite.dev and hopefully it will work and you can install the new site.


## Installation of a roots/bedrock site ##
1. Use "vagrant ssh" to ssh in to the box
2. Use the command "create-bedrock-project mynewsitename" - this will install a new bedrock project in www
3. Connect with fex mysql workbench and create a new database for the site. (See db connection section)
4. Add a new user with access and permissions to your new db.
5. Edit your .env file int the site root.
    * DB_NAME=my-new-db-name

    * DB_USER=my-new-db-user

    * DB_PASSWORD=my-new-db-password

    * WP_ENV=development

    * WP_HOME=http://my-new-sitename.dev

    * WP_SITEURL=http://my-new-sitename.dev

Remove DB_HOST os set it to localhost.
Leave the other parameters unedited.
6. Edit your /etc/hosts file and add "192.168.33.10 mynewsitename.dev". Observe that the sitename will automatically have a .dev.
7. In your new site directory. Edit the .evn file and add the database settings.
8. Browse to mynewsitename.dev in your favorite browser.
9. Follow the wp installation instructions.


## Importing db dumps ##
Use the import-database command. It takes four arguments:
database-name database-user database-user-password sqldumpfile-to-import


## DB Connection ##
For mysql workbench, use:
* SSH Hostname: 192.168.33.20:22
* SSH Username: vagrant
* Mysql Hostname: localhost
* Mysql Server Port: 3306
* Username: root

When connecting passwords are: vagrant and root




