#!/bin/bash

for file in *; do
	testFile=$(tr '[A-Z]' '[a-z]' <<< "$file")
	[ -e "$testFile" ] || mv -- "$file" "$testFile"
done

