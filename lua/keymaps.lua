-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true, -- do not show message
}

-- Normal mode ----------------------------------------------------------------

-- Hint: see `:h vim.map.set()`

-- Better window navigation
-- vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
-- vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
-- vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
-- vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

vim.keymap.set('n', '<C-h>', ':bprev<CR>', opts)
-- vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
-- vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', ':bnext<CR>', opts)

-- split window to the right
vim.keymap.set('n', '<C-S-Right>', ':vsplit<CR>', opt)
vim.keymap.set('n', '<C-S-Down>', ':split<CR>', opt)

-- Resize with arrows
-- delta: 2 line-w-Right
-- TODO: get rid of these because i super dont care about them?
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- allow capital w to be w because I make that typo a lot
-- this uses a different function since this is an Ex command
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})

-- buffer switching
-- buffer switching


-- Visual mode ----------------------------------------------------------------

-- Hint: start visual mode with same area as previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
