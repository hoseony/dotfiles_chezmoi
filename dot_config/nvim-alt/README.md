# nvim-alt reference

Launch this configuration with:

```sh
NVIM_APPNAME=nvim-alt nvim
```

The leader key is `Space`.

## Custom shortcuts

### Finding files and text

| Shortcut | Action |
| --- | --- |
| `Space f f` | Find files |
| `Space f g` | Search text in files |
| `Space f b` | Find an open buffer |
| `Space f h` | Search Neovim help |

### LSP and code navigation

These work when a language server is attached to the current file.

| Shortcut | Action |
| --- | --- |
| `K` | Show documentation and type information under the cursor |
| `g d` | Go to definition |
| `g r` | Find references |
| `Space c a` | Show available code actions |
| `Space r n` | Rename the symbol under the cursor |

### Compiling and running C

| Shortcut | Action |
| --- | --- |
| `Space c c` | Enter or change the compile command, then compile |
| `Space c r` | Repeat the previous compile command |
| `] e` | Jump to the next compiler error |
| `[ e` | Jump to the previous compiler error |
| `Space c x` | Run `./a.out` in a terminal split |

The default C compile command begins with:

```sh
gcc -Wall -Wextra -fno-diagnostics-color
```

The compilation window is moved to the bottom and focused automatically.
Press `q` inside it to close it, or `Ctrl-w k` to return to the code above.
Compiler output is captured without terminal color codes so errors remain
readable and navigable.

### File browser

| Shortcut | Action |
| --- | --- |
| `-` | Open Oil at the current file's parent directory |

Inside Oil, edit the directory listing like a normal buffer and save it to
apply file operations. Press `g?` for Oil's complete shortcut list.

### Markdown preview

| Shortcut | Action |
| --- | --- |
| `Space m r` | Toggle rendered Markdown view |

Markdown files use `render-markdown.nvim` to make headings, lists, code blocks,
tables, quotes, and checkboxes easier to read directly inside Neovim.

## Completion and snippets

These shortcuts apply while typing in Insert mode.

| Shortcut | Action |
| --- | --- |
| `Ctrl-Space` | Open the completion menu |
| `Down` | Select the next completion item |
| `Up` / `Shift-Tab` | Select the previous completion item |
| `Enter` | Accept the explicitly selected item |
| `Ctrl-e` | Close the completion menu |
| `Tab` | Expand or advance a snippet; otherwise select the next completion item |
| `Shift-Tab` | Jump to the previous snippet field |

Completion suggestions come from the language server, snippets, filesystem
paths, and words in open buffers.

Custom C and C++ snippets:

| Trigger | Expansion |
| --- | --- |
| `guard` + `Tab` | Header guard derived from the current file path |
| `func` + `Tab` | Function skeleton with editable return type, name, arguments, and body |

## Diagnostics and hover

- Errors and warnings have an always-visible `■` marker and wrap directly below
  the code where the diagnostic starts.
- Resting the cursor on a symbol for about 700 ms opens its LSP documentation.
- `K` opens the same information immediately.
- Automatic hover uses a rounded, non-focusable floating window.

Useful built-in Neovim diagnostic shortcuts:

| Shortcut | Action |
| --- | --- |
| `g l` | Show the full diagnostic under the cursor |
| `] d` | Go to the next diagnostic |
| `[ d` | Go to the previous diagnostic |

## Built-in Neovim LSP shortcuts

Neovim also provides these globally:

| Shortcut | Action |
| --- | --- |
| `g r t` | Go to type definition |
| `g r i` | Go to implementation |
| `g r r` | Find references |
| `g r n` | Rename symbol |
| `g r a` | Show code actions |
| `g O` | List symbols in the current file |
| `Ctrl-s` in Insert mode | Show function signature help |

## Language support

Mason manages these configured language servers:

- C and C++: `clangd`
- Rust: `rust-analyzer`
- Python: `pyright`
- Bash: `bash-language-server`
- Lua: `lua-language-server`
- Vim script: `vim-language-server`
- Markdown grammar and spelling: `harper-ls`

Useful commands:

| Command | Purpose |
| --- | --- |
| `:LspInfo` | Show language servers attached to the current buffer |
| `:Mason` | View and manage language servers |
| `:checkhealth vim.lsp` | Diagnose LSP problems |

## Git signs

Git changes appear in the sign column:

| Sign | Meaning |
| --- | --- |
| `┃` | Added or changed line |
| `_` | Deleted line |
| `‾` | Deletion above the current line |
| `~` | Changed and deleted content |
| `┆` | Untracked line |

Current-line blame is configured but disabled.

## Editing defaults

- Four-space indentation
- Tabs are converted to spaces
- Absolute and relative line numbers
- System clipboard integration
- True-color terminal support
- Completion menu limited to 10 rows
- Automatic closing of brackets and quotes
- `oldworld.nvim` color scheme
- Friendly Snippets loaded through LuaSnip

## Plugin commands

| Command | Purpose |
| --- | --- |
| `:Lazy` | View and manage plugins |
| `:Compile` | Compile with a selected command |
| `:Recompile` | Repeat the previous compilation |
| `:RenderMarkdown toggle` | Toggle rendered Markdown view |
| `:Oil` | Open the file browser |
| `:copen` | Open the quickfix list |
