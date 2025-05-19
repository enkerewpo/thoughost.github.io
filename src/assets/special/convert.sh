#!/bin/bash

if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it first."
    echo "You can install it using: brew install imagemagick"
    exit 1
fi

find . -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r image; do

    backup_file="${image}.bak"

    if [ ! -f "$backup_file" ]; then
        echo "Backing up: $image"
        cp "$image" "$backup_file"
        source_file="$image"
    else
        echo "Using backup file: $backup_file"
        source_file="$backup_file"
    fi
    
    echo "Processing: $image"
    # if image name is "2.人设三视图.png" then resize to 1000x>
    if [[ "$image" == *"2.人设三视图.png"* ]]; then
        convert "$source_file" -resize "1200x>" "$image"
    else
        convert "$source_file" -resize "500x>" "$image"
    fi
done

echo "All images have been processed"
