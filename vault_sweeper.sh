#!/bin/bash

if [ -z "$1" ]; then #ERR Handling if Directory not given
    echo "Usage: $0 <directory_path>"
    exit 1
fi

dir="$1" #Directory input

if [ -d "$dir" ]; then #Valid directory given
    FORBIDDEN_KEYS="^(PASSWORD|SECRET|TOKEN|PATH)" #Forbidden Keywords list
    find "$dir" -type f \( -name ".env" -o -name ".env.*" -o -name "*.env" -o -name "*.env.*" \) | while read -r fpath; do #find files which have extension .env
        echo "cleaning $fpath"
        tempf="$(mktemp)" #Create a temporary file
        while IFS= read -r line || [[ -n "$line" ]]; do #IFS=Internal File Seperator, reads file line by line, without removing whitespace
            clean_line="$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')" #clean line created by removing whitespaces
            if [[ "$clean_line" =~ ^([A-Za-z_][A-Za-z0-9_]*)=([^[:space:]#\"]+)([[:space:]]*#.*)?$ ]]; then #Check for correct format eg. VARIABLE=VALUE
                var_name="${BASH_REMATCH[1]}" #Get variable name
                var_value="${BASH_REMATCH[2]}" #Get value
                if [[ "$var_name" =~ $FORBIDDEN_KEYS ]]; then # check if variable is in forbidden keys
                    continue
                fi

                echo "$clean_line" >> "$tempf"
            fi
        done < "$fpath" #file path given
        mv "$tempf" "$fpath.sanitized" #rename temporary file
        echo "sanitized $fpath"

    done

else #ERR Handling if invalid directory given
    echo "Invalid directory path: $dir"
    exit 1
fi
