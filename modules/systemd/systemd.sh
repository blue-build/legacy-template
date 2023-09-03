#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

get_yaml_array ENABLED '.system.enabled[]' "$1"
get_yaml_array DISABLED '.system.disabled[]' "$1"
get_yaml_array USER_ENABLED '.user.enabled[]' "$1"
get_yaml_array USER_DISABLED '.user.disabled[]' "$1"


if [[ ${#ENABLED[@]} -gt 0 ]]; then
    for service in "${ENABLED[@]}"; do
        systemctl enable $service
    done
fi
if [[ ${#DISABLED[@]} -gt 0 ]]; then
    for service in "${DISABLED[@]}"; do
        systemctl disable $service
    done
fi
if [[ ${#USER_ENABLED[@]} -gt 0 ]]; then
    for service in "${ENABLED[@]}"; do
        systemctl --user enable $service
    done
fi
if [[ ${#USER_DISABLED[@]} -gt 0 ]]; then
    for service in "${DISABLED[@]}"; do
        systemctl --user disable $service
    done
fi
