#!/bin/bash
set -e

# Always call hugo
if [ "$1" != 'hugo' ]; then
    set -- hugo "$@"
fi

# Ignore "--user -u" option
if [ "$(id -u)" = '0' ]; then

    # Set "--bind" for server
    if [ "$2" = 'server' ]; then
        # Optionally append "--baseURL" and disable "--appendPort"
        if [ -n "${HUGO_BASE_URL}" ]; then set -- "$@" --baseURL "${HUGO_BASE_URL}" --appendPort=false; fi

        set -- "$@" --bind "0.0.0.0"
    fi

    # Step down to user
    USER_MOUNT_UID="$(stat -c '%u' /hugo/site)"
    if [ "${USER_MOUNT_UID}" != '0' ]; then
        if [ -z "$(getent passwd hugo)" ]; then
            addgroup -g "${USER_MOUNT_UID}" hugo
            adduser -u "${USER_MOUNT_UID}" -D -G hugo hugo
        fi

        set -- su-exec hugo "$@"
    fi
fi

echo "Executing CMD \"$@\" ..."

exec "$@"
