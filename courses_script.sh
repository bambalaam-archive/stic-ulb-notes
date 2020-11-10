#!/bin/bash

# ROFI main menu entries
function menu()
{
    echo "1) Pick active course"
    echo "2) Open active course"
    echo "3) Create new lecture in active course"
}

# ROFI entries for course directories
function course_entries()
{
    for a in $(ls -d ~/stic/*/)
    do
        a=${a#~/stic/}
        echo ${a::-1}
    done
}

# ROFI entries for date picker menu
function date_picker()
{
    echo "1) Today"
    echo "2) Enter date manually"
}

# Data of brand new index file
function new_index()
{
    echo -e '\input{../preamble.tex}' \
    '\n''\graphicspath{{images/}}' \
    '\n\n''\\title{}' \
    '\n\n''\\begin{document}' \
    '\n''\maketitle' \
    '\n''\\tableofcontents' \
    '\n''\\newpage' \
    '\n\n''% start lectures' \
    '\n''% end lectures' \
    '\n\n''\\end{document}'
}

# Generate new lecture file
function new_lecture()
{
    if [ ! -f ~/stic/$ACTIVE_COURSE/index.tex ]; then
        # Create main index file if it doesn't exist
        new_index > ~/stic/$ACTIVE_COURSE/index.tex
    fi
    if [ ! -e ~/stic/$ACTIVE_COURSE/lectures/ ]; then
        # Create lectures folder if it doesn't exist
        mkdir ~/stic/$ACTIVE_COURSE/lectures/
    fi
    shopt -s nullglob
    lecture_files=( ~/stic/$ACTIVE_COURSE/lectures/lec* )
    if [ ${#lecture_files[@]} -eq 0 ]; then
        new_lecture_number="01"
    else
        latest_lecture=$(basename "${lecture_files[${#lecture_files[@]}-1]}")
        latest_lecture_number=${latest_lecture#lec_}
        latest_lecture_number=${latest_lecture_number%.tex}
        latest_lecture_number=$((10#$latest_lecture_number))
        new_lecture_number=$(($latest_lecture_number + 1))
        if (( $new_lecture_number >= 2 && $new_lecture_number <= 9 )); then
            new_lecture_number="0$new_lecture_number"
        fi
    fi
    # Create new lecture file
    echo -e "\lecture{$new_lecture_number}{$DATE}" \
    '\n''\\vspace{-1.2cm}'> ~/stic/$ACTIVE_COURSE/lectures/lec_$new_lecture_number.tex
    # Add lecture file to index.tex
    sed -i "/^% end lectures/i \\\\\input{lectures/lec_$new_lecture_number.tex}\n\\\newpage" ~/stic/$ACTIVE_COURSE/index.tex
}

# Check if COURSE is set
function check_active_course()
{
    if [ -z "$ACTIVE_COURSE" ]; then
        echo "" | rofi -dmenu -p "ERROR: > Active course not set in .env file"
        exit 1
    fi
}


ACTIVE_COURSE=$(grep COURSE ~/stic/.env | xargs)
ACTIVE_COURSE=${ACTIVE_COURSE#*=}

# Call main menu
SEL=$( menu | rofi -dmenu -i -p "Select option: " -a 0 -no-custom  | awk '{print $1}' )

if [ "$SEL" == "1)" ]; then
    # Call courses menu
    COURSE=$( course_entries | rofi -dmenu -i -p "Select course: " -a 0 -no-custom  | awk '{print $1}' )
    # Avoid setting empty value in the .env file when pressing ESC
    if [ ! -z "$COURSE" ]; then
        echo "COURSE=${COURSE}" > ~/stic/.env
    fi
elif [ "$SEL" == "2)" ]; then
    check_active_course
    # Open terminal at desired directory
    urxvt -cd ~/stic &
    # Open terminal to make changes
    subl ~/stic/$ACTIVE_COURSE/
    # Open PDF if it exists already
    if [ -f ~/stic/$ACTIVE_COURSE/index.pdf ]; then
        zathura ~/stic/$ACTIVE_COURSE/index.pdf
    fi
elif [ "$SEL" == "3)" ]; then
    check_active_course
    # Call date picker menu
    DATE_SEL=$( date_picker | rofi -dmenu -i -p "Select date: " -a 0 -no-custom  | awk '{print $1}' )
    if [ "$DATE_SEL" == "1)" ]; then
        DATE=$(date +%F)
    elif [[ "$DATE_SEL" == "2)" ]]; then
        DATE=$(echo "" | rofi -dmenu -p "Enter date (YYYY-MM-DD) > ")
    fi
    new_lecture
fi
