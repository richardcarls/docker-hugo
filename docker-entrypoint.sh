#!/bin/bash
set -e

# Ignore "--user -u" and non-hugo commands
if [ "$(id -u)" = '0' ] && [ "$1" = 'hugo' ]; then
    # Step down to user
    USER_MOUNT_UID="$(stat -c '%u' /hugo/site)"
    if [ "${USER_MOUNT_UID}" != '0' ]; then
        addgroup -g "${USER_MOUNT_UID}" hugo
        adduser -u "${USER_MOUNT_UID}" -D -G hugo hugo

        exec su-exec hugo "$@"
    fi
fi

exec "$@"
