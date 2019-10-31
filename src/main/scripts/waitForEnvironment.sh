#!/usr/bin/env bash

export FRONTEND_PORT=9300
export SERVER_NAME=server
export SERVER_PORT=9301
export ENVIRONMENT=Test
#export ADMIN_PASSWORD=Set me in .env

export COMPOSE=/usr/local/bin/docker-compose

function usage() {
  printf "Usage: $0 {test|staging|help}\n\n"
  printf "Options:\n"
  printf "  test        wait for the Test-environment to be up-and-running\n"
  printf "  staging        wait for the Staging-environment to be up-and-running\n"
  printf "  help        show help\n"
  exit 1
}

function run() {
  ACTION="$@"
    case "${ACTION}" in
        test)
            waitFor http://server:9201/domain
            ;;
        staging)
            waitFor http://server:9211/domain
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

function waitFor() {
    url=$1
    timeout=28
    timeWaited=0
    waitTime=0

    echo -n "Waiting for ${url}..."
    while [ ${timeWaited} -lt ${timeout} ]; do
        response=$(curl ${url} --silent)
#        echo "Received: ${response}"
        if [[ ${#response} -gt 2 ]]; then
#            sleep 2
            echo "done!"
            exit 0
        fi

        sleep ${waitTime}
        echo -n "."
        let "timeWaited = ${timeWaited} + ${waitTime}"
        let "waitTime += 1"

    done
    echo "Timeout (${timeWaited}s)!"
    exit 1
}

run $@

