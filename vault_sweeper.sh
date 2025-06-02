#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

dir="$1"

if [ -d "$dir" ]; then
    find "$dir" -type f \( -name ".env" -o -name ".env.*" -o -name "*.env" -o -name "*.env.*" \) | while read -r fpath; do
        echo "cleaning $fpath"
        #tempf="$(mktemp)"
    done

else
    echo "Invalid directory path: $dir"
    exit 1
fi
