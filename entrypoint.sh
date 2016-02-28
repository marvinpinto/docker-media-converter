#!/bin/bash

while true; do

  # Loop through each of the directories specified via the `MEDIA_xxxx`
  # environment variables
  for x in ${!MEDIA_*}; do
    media_dir=${!x}
    find "$media_dir" -type f -name "*.mkv" | while read file; do
      echo "Now converting: $file"
      m_filename=`basename "$file"`
      m_dirname=`dirname "$file"`
      m_filename_wo_ext="${m_filename%.*}"
      m_newfilename="${m_dirname}/${m_filename_wo_ext}.mp4"
      avconv -loglevel error -y -i "$file" -c:v copy -c:a aac -strict experimental "$m_newfilename"
      if [ "$?" -eq 0 ]; then
        echo "Successfully processed: $file"
        /bin/rm -f "$file"
      fi

      # Pause for 10 seconds before moving on to the next file
      sleep 10

    done
  done

  # Trigger a refresh of the Movies & TV Shows sections in plex
  if [ -n "$PLEX_URL" ]; then
    curl -s -H "X-Plex-Token: ${PLEX_TOKEN}" http://${PLEX_URL}/library/sections/1/refresh
    curl -s -H "X-Plex-Token: ${PLEX_TOKEN}" http://${PLEX_URL}/library/sections/2/refresh
  fi

  echo "Media converter going to sleep for 10 mins"
  sleep 600
done
