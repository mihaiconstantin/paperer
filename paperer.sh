#!/bin/bash

# Initialize variables.
DIRECTORY=""
UPDATE=false
UNINSTALL=false

# Initialize flag counter.
FLAGS=0

# Installation directory.
INSTALL_DIR="/usr/local/paperer"

# Display help.
display_help() {
    echo "Usage: $0 [option]" >&2
    echo
    echo "Options:"
    echo "   -d, --directory=DIR    The directory DIR where to prepare the paper"
    echo "   --update               Update 'paperer' from GitHub"
    echo "   --uninstall            Uninstall 'paperer'"
    echo "   --help                 Display this help message"
    echo
    echo "Description:"
    echo "   - Repository: https://github.com/mihaiconstantin/paperer"
    echo "   - Mihai Constantin (mihai@mihaiconstantin.com)"
    echo
    exit 1
}

# Set `git` hooks.
set_git_hooks() {
    # Get the directory from the function argument.
    local DIRECTORY=$1

    # Create `git` hooks.
    cp $INSTALL_DIR/config/gitinfo2.txt "$DIRECTORY/.git/hooks/post-checkout"
    cp $INSTALL_DIR/config/gitinfo2.txt "$DIRECTORY/.git/hooks/post-commit"
    cp $INSTALL_DIR/config/gitinfo2.txt "$DIRECTORY/.git/hooks/post-merge"

    # Make hooks executable.
    chmod +x "$DIRECTORY/.git/hooks/post-checkout"
    chmod +x "$DIRECTORY/.git/hooks/post-commit"
    chmod +x "$DIRECTORY/.git/hooks/post-merge"

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
    mkdir "$DIRECTORY"

    # If `mkdir` failed.
    if [ $? -ne 0 ]; then
        # Exit with error code.
        return 1
    fi

    # Copy template directory contents.
    cp -r $INSTALL_DIR/template/. "$DIRECTORY"

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
    set_git_hooks "$DIRECTORY"

    # Return.
    return 0
}

# Parse command line arguments
for i in "$@"
do
case $i in
    # For the directory option.
    -d=*|--directory=*)
    DIRECTORY="${i#*=}"
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the update flag.
    --update)
    UPDATE=true
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the uninstall flag.
    --uninstall)
    UNINSTALL=true
    FLAGS=$((FLAGS+1))
    shift
    ;;

    # For the help flag.
    -h|--help)
    display_help
    ;;

    # When unknown options or flags are provided.
    *)
    display_help
    ;;
esac
done

# If no flags have been provided.
if [ $FLAGS -eq 0 ]
then
    # Display the help message.
    display_help
fi

# If too many flags have been provided.
if [ $FLAGS -gt 1 ]
then
    # Display an error message.
    >&2 echo "Error: cannot use multiple flags at the same time."

    # Exit with error code.
    exit 1
fi

# If a directory has been provided.
if [ "$DIRECTORY" != "" ]; then
    # Prepare the manuscript.
    prepare

    # If `prepare` failed.
    if [ $? -ne 0 ]; then
        # User feedback.
        >&2 echo "Failed to prepare manuscript at '$DIRECTORY'."

        # Exit with error code.
        exit 1
    fi

    # Otherwise print a message.
    echo "Prepared manuscript at '$DIRECTORY'."
fi

# If an update is requested.
if [ "$UPDATE" = true ]; then
    echo "Updating..."

    # User feedback.
    echo "Successfully updated 'paperer'."
fi

# If uninstall is requested.
if [ "$UNINSTALL" = true ]; then
    echo "Uninstalling..."

    # User feedback.
    echo "Successfully uninstalled 'paperer'."
fi
