not status is-interactive; and begin
    # Use curse input helper when using non-interractive command-line
    set -gx GPG_TTY (tty)
end

# Force the presence of nix profile binaries in PATH
fish_add_path --path /nix/var/nix/profiles/default/bin
