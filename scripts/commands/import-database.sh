if [ "$#" -ne 4 ]; then
	echo "This script needs 4 arguments. The database name, the database user, the database password and the file to import"
	exit
fi

if ! mysql -u"$2" -p"$3" -e "use $1;"; then
  
  # Setup queries
  Q1="CREATE DATABASE IF NOT EXISTS $1;";
	Q2="GRANT USAGE ON *.* TO $2@localhost IDENTIFIED BY '$3';"
	Q3="GRANT ALL PRIVILEGES ON $1.* TO $2@localhost;"
	Q4="FLUSH PRIVILEGES;"
	SQL="${Q1}${Q2}${Q3}${Q4}"

	echo "Creating database, the user and adding the priviliges"
	mysql -uroot -proot -e "$SQL"

	# databasename, dbuser, dbpassword, sqlfile
	echo "Importing database"
	mysql -u"$2" -p"$3" "$1" < "$4"

	echo "Database imported";

else

	echo "The database already exists";

fi


