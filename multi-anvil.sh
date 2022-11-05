#!/usr/bin/env bash
# shellcheck disable=SC1091
source "$(dirname "$0")"/print-utils.sh
set -e


count=$1
config="$(dirname $0)/multi-anvil.json"
if [  ! -f config ]; then
  info "Detected config file, parsing..."
  rpcs=$(cat ${config} | jq ".rpcs")
  info "Found RPC endpoints"
  echo "${rpcs}"
  if [[ ! "$(echo ${rpcs} | jq length)" -eq "${count}" ]]; then
    warning "In fork mode, you can't spawn more Anvil instances than the number of RPC endpoints provided in multi-anvil.json"
    warning "Multi Anvil will now exit.."
    exit 1
  fi
fi

counter=0
announce "Welcome to Multi Anvil"
info "Mullti Anvil will generate ${count} anvil instances"
anvils=""
# shellcheck disable=SC2034
for i in $(seq $((count - 1))); do
  port=$(( 8545 + counter ))
  colour=$(tput setaf ${counter})
  rpc=$(echo "${rpcs}" | jq ".[${counter}]")
  anvils="${anvils} anvil -p ${port} -b 1 -f ${rpc} | sed -e 's/^/  ${colour}anvil[${port}]: /' &"
  info "Anvil instance live at port: ${port}"
  counter=$((counter + 1))
done
colour=$(tput setaf ${counter})
rpc=$(echo "${rpcs}" | jq ".[${counter}]")
port=$(( 8545 + counter ))
anvils="${anvils} anvil -p ${port} -b 1 -f ${rpc} | sed -e 's/^/  ${colour}anvil[${port}]: /'"
info "Anvil instance live at port: ${port}"
(trap 'kill 0' SIGINT; eval "${anvils}")
