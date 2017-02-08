#!/bin/bash

# The working directory where our build will be run
#TODO Sanitize input
WORK=$1
# The directory where we are going to run the build
BUILD="$1/conf"
#

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

# Create symlink to our build conf
if [ -d $BUILD ]; then
	echo "$BUILD already exists"
else
	echo "Creating symlink to build directory on $BUILD"
	ln -s $PWD/build-conf $BUILD
fi

# Symlink to layer
if [ -d $WORK/poky ]; then
	echo "$WORK/yocto already exists"
else
	echo "Creating symlink to layer $WORK/yocto"
	ln -s $PWD/poky $WORK/poky
fi

# Symlink to layer
if [ -d $WORK/meta-openembedded ]; then
	echo "$WORK/meta-openembedded already exists"
else
	echo "Creating symlink to layer $WORK/meta-openembedded"
	ln -s $PWD/meta-openembedded $WORK/meta-openembedded
fi

# Symlink to layer
if [ -d $WORK/meta-raspberrypi ]; then
	echo "$WORK/meta-raspberrypi already exists"
else
	echo "Creating symlink to layer $WORK/meta-raspberrypi"
	ln -s $PWD/meta-raspberrypi $WORK/meta-raspberrypi
fi

source poky/oe-init-build-env $WORK
