#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

get_yaml_array AUTHOR '.author[]' "$1"
get_yaml_array REPONAME '.reponame[]' "$1"
get_yaml_array REPLACE '.replace[]' "$1"

AUTHOR_STR=$(echo "${AUTHOR[*]}" | tr -d '\n')
REPONAME_STR=$(echo "${REPONAME[*]}" | tr -d '\n')
REPLACE_STR=$(echo "${REPLACE[*]}" | tr -d '\n')

elif [[ ${#REPLACE[@]} -gt 0 ]]; then
    echo "Replacing RPMs"
    echo "Replacing: ${REPLACE_STR[*]}"
    rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:$AUTHOR_STR:$REPONAME_STR $REPLACE_STR

