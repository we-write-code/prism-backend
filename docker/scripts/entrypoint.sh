#!/bin/sh

mix deps.get
mix ecto.migrate

exec "$@"
