#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

systemctl enable com.system76.Scheduler.service
