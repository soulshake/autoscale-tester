#!/bin/bash

stderr_echo() {
  echo >&2 "$@"
}

echo=stderr_echo

$echo "SECONDS: ${SECONDS}"

SECONDS=0
$echo "START: $(date)"
$echo "SLEEPING: ${SLEEP} seconds"

echo '{}' | jq .

if ! which gcc; then
  echo "gcc not installed"
  exit 1
else
  echo "installed"
  gcc --version
fi

if [ "${KEEPALIVE}" == true ]; then
  $echo "KEEPING ALIVE"
  while [ "${SECONDS}" -lt "${SLEEP}" ]; do
    $echo "${SECONDS} < ${SLEEP}"
    sleep 300
  done
else
  $echo "NOT KEEPING ALIVE"
  sleep "${SLEEP}"
fi

$echo "END: $(date)"
duration=$SECONDS
$echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
