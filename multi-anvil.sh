#!/usr/bin/env bash
# shellcheck disable=SC1091
source "$(dirname "$0")"/print-utils.sh
set -e

count=$1
counter=0
announce "Welcome to Multi Anvil"
info "Mullti Anvil will generate ${count} anvil instances"
anvils=""
# shellcheck disable=SC2034
for i in $(seq $((count - 1))); do
  port=$(( 8545 + counter ))
  anvils="${anvils} anvil -p ${port} &"
  info "Anvil instance live at port: ${port}"
  counter=$((counter + 1))
done
port=$(( 8545 + counter ))
anvils="${anvils} anvil -p ${port}"
info "Anvil instance live at port: ${port}"
(trap 'kill 0' SIGINT; eval "${anvils}")
