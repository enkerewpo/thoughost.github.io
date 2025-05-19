#!/bin/bash

if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it first."
    echo "You can install it using: brew install imagemagick"
    exit 1
fi

find . -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r image; do
    # Skip backup files and high-res versions
    if [[ "$image" == *".bak"* ]] || [[ "$image" == *"_high"* ]]; then
        continue
    fi

    backup_file="${image}.bak"
    high_res_file="${image%.*}_high.${image##*.}"

    # Create backup if it doesn't exist
    if [ ! -f "$backup_file" ]; then
        echo "Creating backup: $backup_file"
        cp "$image" "$backup_file"
    fi
    
    echo "Processing: $image"
    # Generate low-res version
    if [[ "$image" == *"2.人设三视图.png"* ]]; then
        convert "$backup_file" -resize "1200x>" "$image"
        # Generate high-res version (2x size)
        convert "$backup_file" -resize "2400x>" "$high_res_file"
    else
        convert "$backup_file" -resize "500x>" "$image"
        # Generate high-res version (2x size)
        convert "$backup_file" -resize "1000x>" "$high_res_file"
    fi
done

echo "All images have been processed"
