# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# Steps to set up

1. Install tmux
2. Install neovim and LazyVim
3. Create hotkey for opening tmux `gnome-terminal  --full-screen --working-directory=Documents -- tmux`
4. Use hotkey
5. `Ctrl-X %` to split
6. `Ctrl-X-<Right>` and `Ctrl-X-<Left>` to shrink and grow second panel
7. Set `cd` in both panels
8. Open R / Julia in the right

- `julia --project=.` to avoid needing to do `] activate .`

9. Open neovim to the left
10. Send lines to REPL

- Visual mode to select
- Blocks denoted by `# %%`

# Plugins

- julia-vim
- lspconfig
- matchit
- neogit
- treesitter
- vim-slime
- vim-tmux-navigator

Plus the defaults from LazyVim (???)

# Git interface

- `<Space> g g` opens the visual git window thing
- From there, `a` adds all `<Enter>` adds individual files
- Go down to staged files and press `c` to commit
- Write message and then `<Ctrl-D` to **do** the commit
