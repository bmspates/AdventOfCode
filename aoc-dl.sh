#! /bin/bash

# Downloads the Advent of Code input file for the current (or other specified)
# day.

DAY=$1
YEAR=$2
SESSION=""

[[ -z "$DAY" ]] && DAY=$(date +%d) || : 
[[ -z "$YEAR" ]] && YEAR=$(date +%Y) || :

if [[ ${DAY:0:1} = "0" ]]; then
	DAY=${DAY:1:1}
fi

echo ${DAY:0:1}

DATE=$(date +%s)
PUZZLE_DATE=$(date -d "$YEAR"-12-"$DAY" +%s)

if [[ $DATE -lt $PUZZLE_DATE ]]; then
	echo "Invalid Date! Try again with a published puzzle"
	exit 1
fi

curl https://adventofcode.com/"$YEAR"/day/"$DAY"/input --cookie "session=${SESSION}" --output day"$DAY".txt
