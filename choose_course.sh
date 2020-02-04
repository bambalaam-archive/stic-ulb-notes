#!/bin/bash

# Generate entries with course directories
function gen_entries()
{
    for a in $(ls -d */)
    do
        echo $a
    done
}

# Call menu
SEL=$( gen_entries | rofi -dmenu -p "Select Course: " -a 0 -no-custom  | awk '{print $1}' )

echo "COURSE=${SEL}" > .env
