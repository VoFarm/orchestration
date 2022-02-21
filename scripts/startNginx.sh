#!/bin/bash

nginx -s stop
nginx -c "$PWD"/../nginx/nginx.conf -g "pid /var/run/nginx.pid; worker_processes 2;"
