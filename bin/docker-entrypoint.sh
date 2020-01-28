#!/bin/bash

PORT=${PORT:-3000}

if [[ -z "$@" ]]; then
    ruby -run -ehttpd . -p${PORT}
else
    exec bash -c "$@"
fi
