#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

get_yaml_array ENABLED '.system.enabled[]' "$1"
get_yaml_array DISABLED '.system.disabled[]' "$1"
get_yaml_array USER_ENABLED '.user.enabled[]' "$1"
get_yaml_array USER_DISABLED '.user.disabled[]' "$1"


if [[ ${#ENABLED[@]} -gt 0 ]]; then
    for unit in "${ENABLED[@]}"; do
        unit=$(printf "$unit")
        echo "$unit"
        systemctl list-unit-files | grep $unit
        systemctl enable $unit
    done
fi
if [[ ${#DISABLED[@]} -gt 0 ]]; then
    for unit in "${DISABLED[@]}"; do
        unit=$(printf "$unit")
        echo "$unit"
        systemctl list-unit-files | grep $unit
        systemctl disable $unit
    done
fi
if [[ ${#USER_ENABLED[@]} -gt 0 ]]; then
    for unit in "${ENABLED[@]}"; do
        unit=$(printf "$unit")
        systemctl list-unit-files | grep $unit
        echo "$unit"
        systemctl --user enable $unit
    done
fi
if [[ ${#USER_DISABLED[@]} -gt 0 ]]; then
    for unit in "${DISABLED[@]}"; do
        unit=$(printf "$unit")
        echo "$unit"
        systemctl list-unit-files | grep $unit
        systemctl --user disable $unit
    done
fi
