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
        -- TODO: make this work
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
            zen = { enabled = true }, --
        },
    },

    -- AUTOCOMPLETE
    {
        "saghen/blink.cmp",
        -- use a release tag to download pre-built binaries
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { 
                preset = 'super-tab',
  
            },
            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },
            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
           -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust" }
        },
        opts_extend = { "sources.default" }
    },

    -- BUFFERS (TABS)
    {
        "akinsho/bufferline.nvim", -- TODO: hide buffer when there's only one
        options = {
            -- NOTE: this will be called a lot so don't do any heavy processing here
            custom_filter = function(buf_number, buf_numbers)
                -- filter out by it's index number in list (don't show first buffer)
                if buf_numbers[1] ~= buf_number then
                    return true
                end
            end,
        },
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

    -- HIGHLIGHTING CERTAIN COMMENTS
    {
        "folke/todo-comments.nvim", 
        dependencies = { "nvim-lua/plenary.nvim" },
          -- keywords recognized as todo comments
        keywords = {
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
            fg = "NONE", -- The gui style to use for the fg highlight group.
            bg = "BOLD", -- The gui style to use for the bg highlight group.
        },
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

    -- QUICKLY COMMENT LINES
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

    {
        'altermo/ultimate-autopair.nvim',
        event={'InsertEnter','CmdlineEnter'},
        branch='v0.6', --recommended as each new version will have breaking changes
        opts={
            --Config goes here
        },
    }
})

-- INSTALL
require('nvim-treesitter').install({ 'r', 'julia', 'c', 'python' })

-- SETUP

-- todo comments

require('todo-comments').setup()

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

-- NOTE: NOT NEEDED
-- require('julia-vim').setup()
-- require("nvim-cmp").setup()
-- require('vim-slime').setup()
