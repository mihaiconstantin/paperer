#!/bin/bash

# The current directory of the script.
CURRENT_DIR=$(pwd)

# Installation directory for `paperer`.
INSTALL_DIR="/usr/local/paperer"

# Define the executable directory.
BIN_DIR=/usr/local/bin

# Repository URL fo `paperer`.
REPO_URL="https://github.com/mihaiconstantin/paperer.git"

# Directory where to prepare a new manuscript.
DIRECTORY=""

# Location where templates are stored.
TEMPLATES="$INSTALL_DIR/templates"

# The default template to scaffold.
TEMPLATE="apa"

# Actions to perform on the `paperer` installation.
UPDATE=false
UNINSTALL=false

# Flag counter to protect against too many flags.
FLAGS=0


# Display help.
display_help() {
    echo "Usage: paperer [option]" >&2
    echo
    echo "Options:"
    echo "   -d, --directory=DIR    The directory DIR where to prepare the paper without the trailing slash."
    echo "   -t, --template=TPL     The template TPL to use for scaffolding. The default is 'apa'."
    echo "                          Currently included templates with 'paperer' are: 'apa'."
    echo "                          However, custom templates can be used by specifying the source folder."
    echo "   -s, --source=DIR       Source directory where to look for the template TPL for scaffolding."
    echo "                          The default is the 'templates' folder of the 'paperer' installation."
    echo "                          This option is useful if you want to use your own templates."
    echo "   --update               Update 'paperer' from GitHub."
    echo "   --uninstall            Uninstall 'paperer'."
    echo "   --help                 Display this help message."
    echo
    echo "Description:"
    echo "   - Repository: https://github.com/mihaiconstantin/paperer"
    echo "   - Mihai Constantin (mihai@mihaiconstantin.com)"
    echo
    exit 1
}


# Set `git` hooks.
set_git_hooks() {
    # Create `git` hooks.
    cp $INSTALL_DIR/config/gitinfo2.txt "./.git/hooks/post-checkout" &> /dev/null
    cp $INSTALL_DIR/config/gitinfo2.txt "./.git/hooks/post-commit" &> /dev/null
    cp $INSTALL_DIR/config/gitinfo2.txt "./.git/hooks/post-merge" &> /dev/null

    # If `cp` failed.
    if [ $? -ne 0 ]; then
        # User feedback.
        echo " (!) Error: failed to copy 'git' hooks." >&2

        # Return with error code.
        return 1
    fi

    # Make hooks executable.
    chmod +x "./.git/hooks/post-checkout"
    chmod +x "./.git/hooks/post-commit"
    chmod +x "./.git/hooks/post-merge"

    # Checkout a temporary branch to trigger `gitHeadInfo.gin` creation.
    git checkout --quiet -b setup

    # Checkout the main branch.
    git checkout --quiet main

    # Delete the temporary branch.
    git branch --quiet -D setup

    # Return.
    return 0
}


# Prepare the directory structure.
prepare() {
    # Create the directory.
    mkdir "$DIRECTORY" &> /dev/null

    # If `mkdir` failed.
    if [ $? -ne 0 ]; then
        # User feedback.
        echo " (!) Error: failed to created manuscript directory." >&2

        # Return with error code.
        return 1
    fi

    # Copy template directory contents.
    cp -r "$TEMPLATES/$TEMPLATE/." "$DIRECTORY"

    # Change directory.
    cd "$DIRECTORY"

    # Remove `.gitkeep` files.
    find . -name ".gitkeep" -type f -delete

    # Initialize `.git` repository.
    git init . --quiet

    # Add all files to the repository.
    git add .

    # Commit the changes.
    git commit --quiet -m "Initial commit"

    # Prepare `.git` hooks.
    set_git_hooks

    # If setting the `.git` hooks failed.
    if [ $? -ne 0 ]; then
        # User feedback.
        echo " (!) Error: failed to install 'git' hooks." >&2

        # Return with error code.
        return 1
    fi

    # Change back the directory.
    cd "$CURRENT_DIR"

    # Otherwise return cleanly.
    return 0
}


# Create update function.
update() {
    # Change to installation directory.
    cd "$INSTALL_DIR"

    # Pull the latest changes from GitHub.
    git pull --quiet

    # If `git` failed.
    if [ $? -ne 0 ]; then
        # Return with error code.
        return 1
    fi

    # Remove the previous executable.
    rm $INSTALL_DIR/paperer

    # Rename the executable.
    cp $INSTALL_DIR/paperer.sh $INSTALL_DIR/paperer

    # Make the executable.
    chmod +x $INSTALL_DIR/paperer

    # Change directory back.
    cd "$CURRENT_DIR"

    # Return.
    return 0
}


# Create uninstall function.
uninstall() {
    # Remove the installation directory.
    sudo rm -rf $INSTALL_DIR

    # Remove the executable.
    sudo rm $BIN_DIR/paperer

    # Return.
    return 0
}


# Parse command line arguments
for i in "$@"
do
case $i in
    # For the directory option.
    -d=*|--directory=*)

    # Set the directory.
    DIRECTORY="${i#*=}"

    # Increment the flag counter.
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the template option.
    -t=*|--template=*)

    # Set the template.
    TEMPLATE="${i#*=}"

    # Increment the flag counter.
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the templates location option.
    -s=*|--source=*)

    # Set the templates folder.
    TEMPLATES="${i#*=}"

    # Increment the flag counter.
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the update flag.
    --update)
    # Set the update flag.
    UPDATE=true

    # Increment the flag counter.
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the uninstall flag.
    --uninstall)

    # Set the uninstall flag.
    UNINSTALL=true

    # Increment the flag counter.
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the help flag.
    -h|--help)

    # Display help.
    display_help
    ;;

    # For everything else.
    *)

    # Display help.
    display_help
    ;;
esac
done

# REMOVE THIS COMMENT.

# If no flags have been provided.
if [ $FLAGS -eq 0 ]
then
    # Display the help message.
    display_help
fi


# If an update is requested.
if [ "$UPDATE" = true ]; then
    # User feedback.
    echo " + Updating 'paperer'..."

    # Perform the update.
    update

    # If the `update` failed.
    if [ $? -ne 0 ]; then
        # User feedback.
        echo " (!) Error: failed to update 'paperer'." >&2

        # Return with error code.
        exit 1
    fi

    # User feedback.
    echo " + Successfully updated 'paperer'!"
fi


# If uninstall is requested.
if [ "$UNINSTALL" = true ]; then
    # User feedback.
    echo " + Uninstalling 'paperer'..."

    # Perform the uninstall.
    uninstall

    # If the `uninstall` failed.
    if [ $? -ne 0 ]; then
        # User feedback.
        echo " (!) Error: failed to uninstall 'paperer'." >&2

        # Return with error code.
        exit 1
    fi

    # User feedback.
    echo " + Successfully uninstalled 'paperer'."
fi


# If a directory has been provided.
if [ "$DIRECTORY" != "" ]; then
    # If directory exists, do not proceed.
    if [ -d "$DIRECTORY" ]; then
        # Ask the users to uninstall or update it instead.
        echo " (!) Error: '$DIRECTORY' already exists. Will not proceed." >&2

        # Exit with error code.
        exit 1
    fi

    # If the template does not exist.
    if [ ! -d "$TEMPLATES/$TEMPLATE" ]; then
        # User feedback.
        echo " (!) Error: template '$TEMPLATE' not found." >&2

        # Exit with error code.
        exit 1
    fi

    # User feedback.
    echo " + Preparing the manuscript using the '$TEMPLATE' template..."

    # Prepare the manuscript.
    prepare

    # If `prepare` failed.
    if [ $? -ne 0 ]; then
        # If the directory was created anyway.
        if [ -d "$DIRECTORY" ]; then
            # Remove the directory.
            rm -rf "$DIRECTORY"
        fi

        # User feedback.
        echo " (!) Error: failed to prepare the manuscript at '$DIRECTORY'." >&2

        # Exit with error code.
        exit 1
    fi

    # Otherwise print a message.
    echo " + Manuscript prepared at '$DIRECTORY'."
    echo " + Happy crafting!"
fi
