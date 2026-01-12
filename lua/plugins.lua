-- LAZY SETUP

-- define path where lazy stores stuff
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- initialise if its not there
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
end

-- something
vim.opt.rtp:prepend(lazypath)

-- PLUGINS VIA LAZY
require("lazy").setup({
    
    -- THEME
    {
        "tanvirtin/monokai.nvim",
    },

    -- LSP CONFIGURATION
    {
        "neovim/nvim-lspconfig",
    },

    -- AUTOCOMPLETE
    {
    "hrsh7th/nvim-cmp",  
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        },
    },

    -- FILE VIEWER
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true }, --
            dashboard = { enabled = true }, -- NeoVim dashboard on startup without file
            explorer = { enabled = true }, --
            indent = { enabled = true }, -- shows vertical indent lines
            input = { enabled = true }, --
            picker = { enabled = true }, --
            notifier = { enabled = true }, --
            quickfile = { enabled = true }, --
            scope = { enabled = true }, --
            scroll = { enabled = false }, --
            statuscolumn = { enabled = true }, --
            words = { enabled = true }, --
            zen = {enabled = true }, --
        },
    },

    -- AUTOCOMPLETE
    {
        "saghen/blink.cmp",
    },

    -- BUFFERS (TABS)
    {
        "akinsho/bufferline.nvim",
    },

    -- STATUS LINE
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                component_separators = { left = '|', right = '|'},
                section_separators = { left = '', right = ''},
                theme = "codedark",
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff'},
                lualine_c = {'diagnostics'},
                lualine_x = {'filename', 'fileformat', 'filetype'},
                lualine_y = {''},
                lualine_z = {'location'}
            },
        },
    },

    -- FAST COMMENTING
    {
        "folke/todo-comments.nvim",
    },

    -- TREESITTER
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate"
    },

    -- TELESCOPE
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
    },

    -- GIT
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed.
            "nvim-telescope/telescope.nvim", -- optional
        },
        cmd = "Neogit",
        keys = {
              { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
        }
    },

    -- ICONS
    {
        "nvim-mini/mini.icons",
    },

    -- COMMENTS
    {
        "numToStr/Comment.nvim",
    },

    -- FORMATTING
    {
        "stevearc/conform.nvim",
        opts = {
   
            -- specify how the formatters work
            formatters = {
            
                -- markdown based stuff
                ["markdownlint-cli2"] = {
                  command = "markdownlint-cli2",
                    args = { "--fix" },
                    stdin = true,
                    ignore_stdout = false,
                    ignore_stderr = false, -- still show real errors
                },
                
                -- julia
                ["runic"] = {
                    command = "julia",
                    args = { "--project=@runic", "--startup-file=no", "-e", "using Runic; exit(Runic.main(ARGS))" },
                },
                
                -- python
                ["black"] = {
                    command = "black",
                },
                
                -- r
                ["air"] = {
                    command = "air",
                    args = { "format" },
                },
                
                -- c
                ["clang-format"] = {
                    command = "clang-format",
                },

            },

            -- specify formatters per language
            formatters_by_ft = {
                ["markdown"] = { "markdownlint-cli2" },
                ["julia"] = { "runic" },
                ["r"] = { "air" },
                ["c"] = { "clang-format" },
                ["cpp"] = { "clang-format" },
            },

            -- Notify on errors instead of just logging
            notify_on_error = true,
        },

        -- other options 
        default_format_opts = {
           -- Increase the timeout in case Runic needs to precompile
            -- (e.g. after upgrading Julia and/or Runic).
            timeout_ms = 10000,
        },
        format_on_save = {
            -- I recommend these options. See :help conform.format for details.
            lsp_format = "fallback",
            timeout_ms = 500,
        },
    },
    
    -- slime (REPL integration)
    {
        "jpalardy/vim-slime",
        keys = {
            -- configure with prompts
            {
                "<leader>rc",
                "<cmd>SlimeConfig<cr>",
                desc = "Slime Config"
            },
            -- space enter in visual mode to send selection
            {
                "<leader><CR>",
                ":<C-u>'<,'>SlimeSend<CR>",
                mode = "v",
                desc = "Slime Send Selection"
            },
            -- space enter to send line
            {
                "<leader><CR>",
                "<Plug>SlimeParagraphSend<CR>}",
                desc = "Slime Send Line"
            },
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
    
    -- JULIA LANGUAGE SUPPORT
    {
      "JuliaEditorSupport/julia-vim",
    },

    -- QUARTO SUPPORT
    {
        "quarto-dev/quarto-nvim",
    },
})

-- INSTALL
require('nvim-treesitter').install({ 'r', 'julia', 'c', 'python' })

-- SETUP

-- cmp

-- buffers
require("bufferline").setup()

-- telescope
require('telescope').setup()

-- comments
require('Comment').setup()

-- conform
require('conform').setup()

-- lualine
require('lualine').setup()

-- NOT NEEDED
-- require('julia-vim').setup()
-- require("nvim-cmp").setup()
-- require('vim-slime').setup()
