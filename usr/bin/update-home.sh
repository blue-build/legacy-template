#!/bin/bash

find /usr/home/ -type d | grep -v '\.git' | \
  sed 's|/usr|/var|g' | \
  while IFS= read -r i; do
    [ ! -d "$i" ] && mkdir -p "$i" && chown 1000:1000 "$i" && chmod 755 "$i"
  done

find /usr/home/ -type f | grep -v '\.git' | \
  while IFS= read -r i; do
    dest="$(echo "$i" | sed 's|/usr|/var|g' )"
    cp "$i" "$dest" && chown 1000:1000 "$dest" && chmod 755 "$dest"
  done
