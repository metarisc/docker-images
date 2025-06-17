#!/usr/bin/env sh

# -e : Exit immediately if a pipeline, a list, or a compound command exits with a non-zero status.
# -u : Treat unset variables and parameters other than the special parameters "@" and "*" as an error when performing parameter expansion.
set -eu

DIR=/docker-entrypoint.d
if [[ -d "$DIR" ]]; then
  /bin/run-parts "$DIR"
fi

# Executing the Dockerfile's CMD 
exec "$@"