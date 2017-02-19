#!/bin/bash

# The working directory where our build will be run
#TODO Sanitize input
WORK=$1
# The directory where we are going to run the build
BUILD="$1/conf"
# Where our poky directory is found
POKY="$PWD/poky"
# Where the local conf is found
CONF="$PWD/conf"

# Check that a workspace has been given
if [ -z "$WORK" -a "$WORK" != " " ]; then
        echo "A workspace has to be given"
	exit 1
fi

# Create work directory if it does not exist
if [ ! -d $WORK ]; then
	echo "Creating $WORK directory"
	mkdir -p $WORK
fi

# Check that the poky direcctory exists
if [ ! -d $POKY ]; then
	echo "$POKY directory not found, are you sure you have intialized all 
			gitsubmodules in this repo?"
	exit
fi

# Check that the conf directory exists
if [ ! -d $CONF ]; then
	echo "$CONF directory not found, are you sure you have intialized all 
			gitsubmodules in this repo?"
	exit
fi

# Change the .templateconf in poky to always find our sample configurations, if
# we want to upgrade poky in git, we just have to disard changes in this submodule
echo "##### Modified by the init.sh script, if you want to upgrde poky, do so ######
##### by discardig changes done to this file in git                           ######
TEMPLATECONF=\${TEMPLATECONF:-$CONF}" > $POKY/.templateconf

source poky/oe-init-build-env $WORK
