#!/bin/sh

# REQUIRES: command -v clangd

. test/lib.sh

cat > main.c << EOF
void foo() {}
void bar() { foo(); }
EOF

$tmux new-session -d kak -e "$kak_startup_commands; lsp-enable" main.c
$tmux resize-window -x 80 -y 5
sleep .3
$tmux send-keys j / foo Enter gd
sleep .3
$tmux send-keys 'i%()' Escape

$tmux capture-pane -p

# CHECK: void %()foo() {}
# CHECK: void bar() { foo(); }
# CHECK: ~
# CHECK: ~
# CHECK: main.c 1:9 [+] 1 sel - client0@[{{\d+}}]
