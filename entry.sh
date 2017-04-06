#!/bin/bash
set -e

USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}


# Create user group:
if ! getent group spotify >/dev/null; then
	groupadd -f -g ${USER_GID} spotify
fi

# Create user with UID and GID matching the host user:
if ! getent passwd spotify >/dev/null; then
	adduser --uid ${USER_UID} --gid ${USER_GID} \
		--disabled-login \
		--gecos 'Spotify' spotify

	ln -s /data/cache /home/spotify/.cache
	ln -s /data/config /home/spotify/.config
fi

# Set ownership for application files:
chown -R spotify:spotify /data


exec su spotify -c spotify
