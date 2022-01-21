REF := master
SHELL := /bin/zsh

# General nix

nix-installer:
	sh <(curl -L https://nixos.org/nix/install) --daemon

nix-unstable:
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
	nix-channel --update

nix-info:
	nix-shell -p nix-info --run "nix-info -m"

uninstall-nix:
	@echo "Removing these directories:\n\t/etc/profile/nix.sh /etc/nix /nix ~root/.nix-profile ~root/.nix-defexpr ~root/.nix-channels ~/.nix-profile ~/.nix-defexpr ~/.nix-channels"
	sudo rm -rf /etc/profile/nix.sh /etc/nix /nix ~root/.nix-profile ~root/.nix-defexpr ~root/.nix-channels ~/.nix-profile ~/.nix-defexpr ~/.nix-channels
	@echo "Unloading nix-daemon.plist"
	sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
	@echo "Deleting nix-daemon.plist"
	sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist

nix-failed-install:
	-sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
	-sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
	-sudo mv /etc/zshrc.backup-before-nix /etc/zshrc

# nix-darwin

ensure-daemon:
	. /etc/static/zshrc

nix-darwin-build:
	nix-build https://github.com/LnL7/nix-darwin/archive/${REF}.tar.gz -A installer

nix-darwin-install:
	mkdir -p "${HOME}/.nixpkgs"
	cp ./nix-darwin/darwin-configuration.nix "${HOME}/.nixpkgs"
	./result/bin/darwin-installer

nix-darwin-bootstrap: nix-darwin-build nix-darwin-install

darwin-reload:
	darwin-rebuild switch -I "darwin-config=${HOME}/code/nixconfig/machines/macos/rhodenite/darwin-configuration.nix"

# home-manager

home-manager-install:
	nix-channel --add https://github.com/nix-community/home-manager/archive/${REF}.tar.gz home-manager
	nix-channel --update
