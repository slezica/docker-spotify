# Spotify Container for Docker

Run Spotify inside an Ubuntu container, sharing the X11 and PulseAudio sockets
from the host.


## Usage

1. Clone this repository and `cd` into it:

  ```bash
  git clone git@github.com:slezica/docker-spotify.git && cd docker-spotify
  ```

2. Build the Docker container:

  ```bash
  docker build -t spotify .
  ```

3. Run the start-up script:

  ```bash
  bin/spotify
  ```


## Volumes

Two external folders are linked inside the container:


- The `$HOME/.docker-volumes/spotifyconfig` directory is mounted into `/data/config`
inside the container, to persist sessions and configuration.

- The `$HOME/music` directory is made available as `/data/music` inside the
container, for use with the Local Files feature.


To change these paths, edit `bin/spotify`.


## Adding Gnome application

Place this file (editing the relevant paths) into `~/.local/shares/application`:

  ```
  #!/usr/bin/env xdg-open
  [Desktop Entry]
  Version=1.0
  Terminal=false
  Type=Application
  Name=Spotify
  Icon=docker-spotify/icon.png
  Exec=docker-spotify/bin/spotify
  ```
