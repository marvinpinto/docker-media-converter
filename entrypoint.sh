#!/bin/bash

# Get all environment variables that begin with "MEDIA_"
for x in ${!MEDIA_*}; do
  echo "$x"
done
