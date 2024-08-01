#!/bin/bash

# Directory to organize
TARGET_DIR="$1"

# Check if directory is provided
if [ -z "$TARGET_DIR" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Navigate to the target directory
cd "$TARGET_DIR" || exit

# Loop through each file in the directory
for file in *; do
    # Check if it's a file
    if [ -f "$file" ]; then
        # Get the file extension
        EXT="${file##*.}"
        # Get the last modified date (year and month)
        MOD_DATE=$(date -r "$file" +"%Y/%m")

        # Create the target directory structure
        mkdir -p "$EXT/$MOD_DATE"

        # Move the file to the new location
        mv "$file" "$EXT/$MOD_DATE/"
    fi
done

echo "Files organized by extension and date."
