#!/bin/sh

# REQUIRES: command -v rust-analyzer

{ # Braces to get predictable behavior when editing this file while it's running.

. test/lib.sh

# rust-analyzer needs a project.
cat > Cargo.toml << EOF
[package]
name = "example"
version = "0.1.0"
EOF

mkdir src
cat > src/main.rs << EOF
struct SomeStruct {
	some_field: bool
}
fn test() {
	let x = SomeStruct{some_field: false};
}
EOF

cat > local-kak-lsp.toml << EOF
[language.rust]
filetypes = ["rust"]
roots = ["."]
command = "rust-analyzer"
EOF

kak_startup_commands="$kak_startup_commands
set global lsp_cmd \"kak-lsp -c local-kak-lsp.toml -s %val{session} -vvv --log log\"
lsp-enable
lsp-diagnostic-lines-disable global
"

$tmux new-session -d kak  -e "$kak_startup_commands" src/main.rs

$tmux send-keys '/let x' Enter
sleep 4 # rust-analyzer can be slow to start up.
$tmux send-keys o x.

if test -n "$INTERACTIVE"; then
	$tmux attach
fi

sleep 4
$tmux capture-pane -p -S 3 -E 7

# CHECK: fn test() {
# CHECK: let x = SomeStruct{some_field: false};
# CHECK: x.
# CHECK: } {{ *}} into       Method{{.*}}
# CHECK: ~ {{ *}} some_field Field{{.*}}

}
