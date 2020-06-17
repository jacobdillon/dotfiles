#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "Usage: setup.sh host"
    exit 2
fi

if ls `pwd`/$1.nix 1>/dev/null 2>&1; then
    sudo ln -sf `pwd`/$1.nix /etc/nixos/configuration.nix
else
    echo "Configuration for host " $1 "was not found..."
    exit 3
fi

nix-channel --add https://github.com/rycee/home-manager/archive/release-20.03.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update

nix-shell '<home-manager>' -A install
