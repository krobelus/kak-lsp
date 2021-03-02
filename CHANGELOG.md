## Unreleased

Breaking changes:
- Buffers `*goto*`, `*symbols*`, `*diagnostics*` are given the `lsp-goto` filetype instead of `grep` or `make` (#454).
- Hidden commands `lsp-{next,previous}-match` were removed in favor of `lsp-{next,previous}-location` (#466).

Additions:
- New commands `lsp-{next,previous}-location` generalize `grep-next-match`, `lsp-next-match` and friends (#466).
- `lsp-rename-prompt` is added to to the `lsp` user mode, mapped to `R` (#441).

Bug fixes:
- `lsp-show-{diagnostics,goto-choices,document-symbols}` no longer `cd` to the project root (#454).
- Fix error when the documentation part of a completion item starts with a dash (`-`) (#460).
- Fix completions of non-ASCII characters when using textEdit (which is not only partially supported) (#455).

Deprecations:
- `lsp-{goto,symbols}-{next,previous}-match` are deprecated in favor of `lsp-next-location *goto*` and similar (#466).

For release notes on v9.0.0 and older see <https://github.com/kak-lsp/kak-lsp/releases>.
