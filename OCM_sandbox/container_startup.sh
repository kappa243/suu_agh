#!/bin/bash

ulimit -n 4096

service docker start

exec "$@"
