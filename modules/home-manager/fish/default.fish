not status is-interactive; and begin
    # Use curse input helper when using non-interractive command-line
    set -gx GPG_TTY (tty)
end
