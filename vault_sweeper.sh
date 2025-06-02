#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

dir="$1"

if [ -d "$dir" ]; then
    find "$dir" -print
else
    echo "Invalid directory path: $dir"
    exit 1
fi
