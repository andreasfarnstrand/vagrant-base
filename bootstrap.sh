#!/usr/bin/env bash

webdirectory=www
scriptsdirectory=scripts
dbdirectory=db

# Create the forlder for the websites
if [ ! -d "$webdirectory" ]; then
	mkdir $webdirectory
fi

# Create the forlder for custom scripts
if [ ! -d "$scriptsdirectory" ]; then
	mkdir $scriptsdirectory
fi

# Create the folder for db dumps
if [ ! -d "$dbdirectory" ]; then
	mkdir $dbdirectory
fi