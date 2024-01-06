#!/usr/bin/env bash

SRC="$1"
DEST="$2"

echo "Moving pictures from: $SRC to $DEST<YEAR>/<MONTH>"

FILES="$(ls -p $SRC | grep -v '/')"

YEAR_MONTHS="$(echo $FILES | grep -Eo '(20|19)[0-9]{6}_' | awk ' {print substr($0,0,4) "/" substr($0,5,2)}' | sort | uniq )"
for folder in $YEAR_MONTHS
do
	mkdir -p $DEST/$folder
	FNAME="$(echo $folder | sed 's/\///')"
	TO_MOVE="$(ls $SRC | grep $FNAME)"
	for tm in $TO_MOVE
	do
		mv "$SRC/$tm" $DEST/$folder
	done
done
