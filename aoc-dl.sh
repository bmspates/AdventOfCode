#! /bin/bash

# Downloads the Advent of Code input file for the current (or other specified)
# day.
# 
# Usage: aoc-dl [DAY] [YEAR]

DAY=$1
YEAR=$2
CURRENT_YEAR=$(date +%Y)
SESSION=""

[[ -z "$DAY" ]] && DAY=$(date +%d) || : 
[[ -z "$YEAR" ]] && YEAR=$CURRENT_YEAR || :

if [[ $DAY -gt 25 || $DAY -lt 1 ]]; then
	echo "Invalid Date! Try again with a puzzle released between December 1-25"
	exit 1
fi

if [[ $YEAR -lt 2015 || $YEAR -gt $CURRENT_YEAR ]]; then
	echo "Invalid Date! Try again with a puzzle released between 2015-${CURRENT_YEAR}"
	exit 1
fi

DATE=$(date +%s)
PUZZLE_DATE=$(date -d "$YEAR"-12-"$DAY" +%s)

if [[ $DATE -lt $PUZZLE_DATE ]]; then
	echo "Invalid Date! Try again with a published puzzle"
	exit 1
fi

curl https://adventofcode.com/"$YEAR"/day/"$DAY"/input --cookie "session=${SESSION}" --output day"$DAY".txt
