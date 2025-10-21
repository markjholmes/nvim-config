return {
  -- slime (REPL integration)
  {
    "jpalardy/vim-slime",
    keys = {
      -- configure with prompts
      { "<leader>rc", "<cmd>SlimeConfig<cr>", desc = "Slime Config" },
      -- space enter in visual mode to send selection
      { "<leader><CR>", ":<C-u>'<,'>SlimeSend<CR>", mode = "v", desc = "Slime Send Selection" },
      -- space enter to send line
      { "<leader><CR>", "<Plug>SlimeParagraphSend<CR>}", desc = "Slime Send Line" },
    },
    config = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = {
        socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)'),
        target_pane = "{bottom-right}",
      }
      vim.g.slime_preserve_curpos = 0
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_python_ipython = 1
      vim.g.slime_bracketed_paste = 1
    end,
  },
}
