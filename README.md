# media-converter

[![Build Status](https://img.shields.io/travis/marvinpinto/docker-media-converter/master.svg?style=flat-square)](https://travis-ci.org/marvinpinto/docker-media-converter)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE.txt)
[![Quay.io](https://quay.io/repository/marvin/media-converter/status)](https://quay.io/repository/marvin/media-converter)

A docker container to convert your `mkv` files to an `mp4` format which Plex is
capable of direct streaming.

### How does it work?

It searches through a specified list of directories for all files ending with
`*.mkv` and then uses the `avconv` tool to convert these files to the `mp4`
format.

### How do I use this?

You should be able to run the docker container using something along the lines
of:

```bash
docker run -d \
  -e "MEDIA_TVSHOWS=/tv" \
  -e "MEDIA_MOVIES=/movies" \
  -e "PLEX_URL=http://127.0.0.1:32400" \
  -e "PLEX_TOKEN=sekr3t" \
  -v "/opt/data/tv:/tv" \
  -v "/opt/data/movies:/movies" \
  quay.io/marvin/media-converter
```

Few things to keep in mind here:

- `MEDIA_xxx` environment variables: These variables should point to the
mounted _media_ directories. Supply as many you need. The [entrypoint.sh][1]
script will handle iterating over each of those directories and converting
those `mkv` files as needed.

- `PLEX_URL`: If you supply a plex URL, the [entrypoint.sh][1] script will take
care of triggering a media refresh after each cycle. Note that you will also
need a `PLEX_TOKEN` variable here (see [Finding your account token][2]).

[1]: entrypoint.sh
[2]: https://support.plex.tv/hc/en-us/articles/204059436-Finding-your-account-token-X-Plex-Token
