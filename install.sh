#!/bin/bash

# Define the install directory.
INSTALL_DIR=/usr/local

# Define the executable directory.
BIN_DIR=/usr/local/bin

# Create the full path for the `paperer` installation.
INSTALL_DIR=$INSTALL_DIR/paperer

# User feedback.
echo " + Cloning the 'paperer' repository..."

# Close the repository at the install location.
git clone --depth 1 https://github.com/mihaiconstantin/paperer.git $INSTALL_DIR &> /dev/null

# User feedback.
echo " + Installing 'paperer'..."

# Rename the executable.
cp $INSTALL_DIR/paperer.sh $INSTALL_DIR/paperer

# Make the executable executable.
chmod +x $INSTALL_DIR/paperer

# Create a symbolic link to the executable.
ln -sf $INSTALL_DIR/paperer $BIN_DIR/paperer

# User feedback.
echo " + Installed 'paperer' successfully! Type 'paperer --help' to get started."
