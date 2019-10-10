#!/usr/bin/env sh

if [ `id -u` -ne 0 ]; then
    echo "Please rerun with root access."
    exit 1
fi

if [ -z "$1" ]; then
    echo "Usage: setup.sh host"
    exit 2
fi

if ls `pwd`/$1.nix 1>/dev/null 2>&1; then
    ln -sf `pwd`/$1.nix /etc/nixos/configuration.nix
else
    echo "Configuration for host " $1 "was not found..."
    exit 3
fi

