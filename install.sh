#!/bin/bash

# Define the install directory.
INSTALL_DIR=/usr/local

# Define the executable directory.
BIN_DIR=/usr/local/bin

# Create the full path for the `paperer` installation.
INSTALL_DIR=$INSTALL_DIR/paperer

# If `paperer` is already installed.
if [ -d "$INSTALL_DIR" ]; then
    # Ask the users to uninstall or update it instead.
    echo " (!) Error: 'paperer' is already installed. Please first uninstall or update using 'paperer --update'." >&2

    # Exit with error code.
    exit 1
else
    # Indicate that no prior installation was found.
    echo " + No prior installation of 'paperer' detected."
fi

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
