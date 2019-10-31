#!/usr/bin/env bash

export FRONTEND_PORT=9320
export SERVER_NAME=featr.kranenburg.online
export SERVER_PORT=9321
export ENVIRONMENT=Production
#export ADMIN_PASSWORD=Set me in .env

export COMPOSE=/usr/local/bin/docker-compose

function usage() {
  printf "Usage: $0 {up|config|help}\n\n"
  printf "Options:\n"
  printf "  up          create and start\n"
  printf "  start       start\n"
  printf "  stop        stop\n"
  printf "  config      show config\n"
  printf "  help        show help\n"
  exit 1
}

function run() {
  ACTION="$@"
    case "${ACTION}" in
        up)
            ${COMPOSE} --project-name ${ENVIRONMENT} up -d
            ;;
        start)
            ${COMPOSE} --project-name ${ENVIRONMENT} start
            ;;
        stop)
            ${COMPOSE} --project-name ${ENVIRONMENT} stop
            ;;
        config)
            ${COMPOSE} --project-name ${ENVIRONMENT} config
            ;;
        help)
            usage
            ;;
        *)
            echo "Unknown option: [${ACTION}]"
            usage
            ;;
    esac
}

run $@

