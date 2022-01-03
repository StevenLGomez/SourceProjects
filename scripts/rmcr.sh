#!/bin/sh

# Need to add support for $1, but the shell line needed is:

# mv $1 $1DOS.sh  <-- need to extract base name from full name
tr -d "\r" < $1DOS.sh > $1

