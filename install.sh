#!/bin/bash

# Define the install directory.
INSTALL_DIR=/usr/local

# Define the executable directory.
BIN_DIR=/usr/local/bin

# User feedback.
echo "Cloning the 'mihaiconstantin/paperer' repository..."

# Close the repository at the install location.
git clone --depth 1 https://github.com/mihaiconstantin/paperer.git $INSTALL_DIR &> /dev/null

# User feedback.
echo "Installing 'paperer'..."

# Rename the executable.
mv $INSTALL_DIR/paperer/paperer.sh $INSTALL_DIR/paperer/paperer

# Make the executable executable.
chmod +x $INSTALL_DIR/paperer/paperer

# Create a symbolic link to the executable.
ln -s $INSTALL_DIR/paperer/paperer $BIN_DIR/paperer

# User feedback.
echo "Installed 'paperer' successfully! Type 'paperer --help' to get started."
