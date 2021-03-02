## Unreleased

Breaking changes:
- The semantic highlighting feature has been removed. It is superseded by semantic tokens which are officially part of LSP 3.16.
- Buffers `*goto*`, `*symbols*`, `*diagnostics*` are given the `lsp-goto` filetype instead of `grep` or `make` (#454).
- `ocamllsp` replaces the discontinued `ocaml-language-server` as default language server for OCaml (#471).
- Hidden commands `lsp-{next,previous}-match` were removed in favor of `lsp-{next,previous}-location` (#466).

Additions:
- New commands `lsp-{next,previous}-location` generalize `grep-next-match`, `lsp-next-match` and friends (#466).
- New option `lsp_location_format` to tell `lsp-{next,previous}-location` which "<file>:<line>"-style to match (#466).
- `lsp-rename-prompt` is added to to the `lsp` user mode, mapped to `R` (#441).
- Default configuration for CSS variants "less" and "scss" (#473).
- `kak-lsp` sends the configured offset encoding to the language server (see https://clangd.llvm.org/extensions.html#utf-8-offsets), which still defaults to `utf-16`.
- `lua-language-server` was added as default language server for Lua.

Bug fixes:
- `lsp-show-{diagnostics,goto-choices,document-symbols}` no longer `cd` to the project root (#454).
- Fix error when the documentation part of a completion item starts with a dash (`-`) (#460).
- Fix completions of non-ASCII characters when using textEdit (which is not only partially supported) (#455).
- Fix `lsp-rename` with `pyright` (#468).
- Treat snippets containing `<` literally, instead of as Kakoune key names (#470)
- Fix edits (by `lsp-rename` and friends) to files that were not opened as Kakoune buffers (#481).
- Nested entries in `lsp_server_initialization_options` like `a.b=1` are sent to language servers as `{"a":{"b":1}}` instead of `{"a.b":1}` (#480).
- Fix a case where `lua-language-server` would hang (#479) because `kak-lsp` didn't support `workspace/configuration`; basic support has been added.

Deprecations:
- `lsp-{goto,symbols}-{next,previous}-match` are deprecated in favor of `lsp-next-location *goto*` and similar (#466).

For release notes on v9.0.0 and older see <https://github.com/kak-lsp/kak-lsp/releases>.
