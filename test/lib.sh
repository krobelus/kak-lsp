#!/bin/sh

# Change to a new HOME and sets $tmux and $kak_startup_commands.

set -e

# This test requires tmux.
command -v tmux >/dev/null

# Export a fresh HOME, so Kakoune is run without user configuration.
HOME=$(mktemp -d)
cd "$HOME"

# Isolated tmux.
tmux="tmux -S $HOME/.tmux-socket -f $HOME/.tmux.conf"

kak_startup_commands="
	evaluate-commands %sh{kak-lsp --kakoune -s \$kak_session}
	map global user l %{: lsp-enable<ret>}
	# Enable logging since this is only for testing.
	set-option global lsp_cmd \"kak-lsp -s %val{session} -vvv --log ./log\"
"

cat > "$HOME"/.tmux.conf << EOF
# Pass escape through with little delay, as suggested by the Kakoune FAQ.
set -sg escape-time 25
EOF

cleanup() {
	if test -n "$cleanup_done"; then
		return
	fi
	$tmux kill-server ||:
	rm -rf "$HOME"
	cleanup_done=true
}
trap cleanup EXIT INT HUP TERM QUIT
