#!/bin/sh

# NOTE --no-check-certificate disables TLS certificate verification; use only with trusted sites/networks

wget --mirror --no-check-certificate --page-requisites --convert-links --adjust-extension   --no-parent --wait=1 --directory-prefix=./backup   https://wb0hsi.org

