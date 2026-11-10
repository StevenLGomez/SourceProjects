#!/bin/bash

MODEL='--model small'
LANGUAGE='--language English'

raw_name=$(echo "$1" | cut -f 1 -d '.')
clear
echo '====================================================='
echo 'Converting ' $raw_name'.flac to' $raw_name'.mp3 using command:'
echo 'lame' $raw_name.flac $raw_name.mp3

lame $raw_name.flac $raw_name.mp3

echo '====================================================='
echo 'Converting ' $raw_name'.mp3 to' $raw_name'.txt using command:'
echo 'whisper' $raw_name.mp3 $MODEL $LANGUAGE

whisper $raw_name.mp3 $MODEL $LANGUAGE 

