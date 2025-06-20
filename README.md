# 💤 LazyVim

Using the [LazyVim](https://github.com/LazyVim/LazyVim) starter template. See the [documentation](https://lazyvim.github.io/installation).

# Steps to set up

1. Install tmux
2. Get nerd fonts (just icons) https://github.com/ryanoasis/nerd-fonts/releases/
3. Install neovim and LazyVim
4. Create hotkey for opening tmux `gnome-terminal  --full-screen --working-directory=Documents -- tmux`
5. Use hotkey
6. `Ctrl-X %` to split
7. `Ctrl-X-<Right>` and `Ctrl-X-<Left>` to shrink and grow second panel
8. Set `cd` in both panels
9. Open R / Julia in the right

- `julia --project=.` to avoid needing to do `] activate .`

10. Open neovim to the left
11. Send lines to REPL

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
- `p` to push
- `: q` to exit git window

# Slime

- Visual mode to select
- Blocks denoted by `# %%`
- `<Space> r r` to send to REPL
