#!/bin/sh

wget --mirror # Enables recursion, time-stamping, infinite recursion depth & keeps FTP dir listings  \
    --no-check-certificate # disables TLS cert verification, use only with trusted sites             \
    --page-requisites # Downloads all files necessary to properly display a given HTML page          \
    --convert-links # converts links for local viewing (after download completes)                    \
    --adjust-extension  # Attempts to rename to .html to make them locally viewable                  \
    --no-parent # Never ascend to the parent directory when retrieving recursiely                    \
    --wait=1 # Seconds to wait between retrievals (reduces server load)                              \
    --directory-prefix=./backup   # Target directory where all other files & subdirs will be saved   \
    https://wb0hsi.org

