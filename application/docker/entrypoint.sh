#!/usr/bin/env bash
# This script is used to set the UID and GID of the 'node'
# user to the same as the host user.
# This is useful when mounting volumes, as the host user
# may not have the same UID and GID as the 'node' user in
# the container, which can cause permission issues.
# The script can be run as the entrypoint of the container,
# with the command to run as the arguments.
# Example: docker run -it --entrypoint /app/docker/with-current-user-ids.sh my-image npm start
# NOTE: This script assumes that the 'node' user exists in the
# container, and that the 'node' user has sudo privileges.
# Additionally, you must ensure the node user can execute the shell file.
# It has dependencies on bash and shadow and requires sudo
# ```
# RUN apk --no-cache add bash shadow
# RUN set -ex && apk --no-cache add sudo
# RUN chown node:node /usr/src/app/run-with-current-user-ids.sh
# RUN chmod +x /usr/src/app/run-with-current-user-ids.sh
# ```

set -e

if [[ -z "$HOST_UID" ]]; then
    echo "ERROR: please set HOST_UID" >&2
    exit 1
fi
if [[ -z "$HOST_GID" ]]; then
    echo "ERROR: please set HOST_GID" >&2
    exit 1
fi

groupmod --gid "$HOST_GID" node
usermod --uid "$HOST_UID" node

# Drop privileges and run the command as the 'node' user
su node

if [[ $# -gt 0 ]]; then
    "$@"
else
    echo "ERROR: no command to run" >&2
    exit 2
fi