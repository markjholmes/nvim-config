return {
  -- slime (REPL integration)
  {
    "jpalardy/vim-slime",
    keys = {
      { "<leader>rc", "<cmd>SlimeConfig<cr>", desc = "Slime Config" },
      { "<leader>rr", "<Plug>SlimeSendCell<BAR>/^# %%<CR>", desc = "Slime Send Cell" },
      { "<leader>rr", ":<C-u>'<,'>SlimeSend<CR>", mode = "v", desc = "Slime Send Selection" },
    },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = {
        socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)'),
        target_pane = "{bottom-right}",
      }
      vim.g.slime_cell_delimiter = "# %%"
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_python_ipython = 1
      vim.g.slime_bracketed_paste = 1
    end,
  },
}
