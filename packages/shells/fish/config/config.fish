# Sylvie Poulsen
# 2019-2022

## Useful commands:

# Add something to $fish_user_paths:
# set fish_user_paths /Users/spoulsen/.nix-profile/bin $fish_user_paths

# Add something permanently to $fish_user_paths:
# set -U fish_user_paths /Users/spoulsen/.nix-profile/bin $fish_user_paths

# Remove something from $fish_user_paths (fish_user_paths is a 1-indexed list):
# set --erase fish_user_paths[index]

# Remove something permanently from $fish_user_paths:
# set --erase -U fish_user_paths[index]


## BEGIN CONFIG

# Pure theme configuration
# REF: https://github.com/rafaelrinaldi/pure#configuration
if test $TERM = 'dumb'
    # Tramp workaround
    set pure_symbol_prompt "\$ "
  else
    set pure_symbol_prompt λ
end

# Erlang shell history
set -gx ERL_AFLAGS "-kernel shell_history enabled"

set -xg TZ "America/New_York"

set -xg iCloudDrive "~/Library/Mobile\ Documents/com\~apple\~CloudDocs/"

# Enable gpg auth for ssh
set -x GPG_TTY (tty)
set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

if functions -q load_nix
    load_nix
end

# direnv hook fish | source
set -g fish_user_paths /etc/profiles/per-user/sylvie/bin $fish_user_paths
direnv hook fish | source

# set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths

fenv source /run/current-system/etc/zshenv > /dev/null
fish_add_path -p /nix/var/nix/profiles/per-user/sylvie/home-manager/home-path/bin /run/current-system/sw/bin
