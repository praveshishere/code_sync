#!/bin/bash

# Path to the file containing repo names
repos_file="repos.txt"

# Path to the file containing the prefix
prefix_file="prefix.txt"

# Read the prefix from the prefix file
prefix=$(<"$prefix_file")

# Read repos.txt line by line
while IFS= read -r repo_name; do
    # Check if directory exists, if not clone the repo
    if [ ! -d "$repo_name" ]; then
        # Clone the repo
        git clone "${prefix}${repo_name}" || continue
    fi

    # Change directory to the repo
    cd "$repo_name" || continue

    # Perform operations in the repo directory
    echo "Currently in $(pwd)"

    # Run another script with params dev and qa
    ../sync_repo.sh dev qa || continue

    # Change back to the original directory
    cd ..

done < "$repos_file"
