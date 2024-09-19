return {

    {
        'catppuccin/nvim',
        config = function()
            require('catppuccin').setup()
            vim.cmd([[
                augroup user_colors
                autocmd!
                autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
                autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
                autocmd ColorScheme * highlight NormalFloat ctermbg=NONE guibg=NONE
                autocmd ColorScheme * highlight NormalFloatNC ctermbg=NONE guibg=NONE
                autocmd ColorScheme * highlight NeoTreeNormal ctermbg=NONE guibg=NONE
                autocmd ColorScheme * highlight NeoTreeNormalNC ctermbg=NONE guibg=NONE
                augroup END
                ]])
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
        lazy = false,
        priority = 1000,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'bash', 'c', 'cpp', 'css', 'diff', 'dockerfile', 'git_config', 'git_rebase',
                    'gitattributes', 'gitcommit', 'gitignore', 'go', 'gomod', 'gosum', 'gpg',
                    'html', 'javascript', 'jsdoc', 'json', 'latex', 'lua', 'luadoc', 'make',
                    'markdown', 'markdown_inline', 'python', 'regex', 'requirements', 'scss',
                    'sql', 'ssh_config', 'tmux', 'toml', 'typescript', 'vim', 'vimdoc', 'yaml',
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                auto_install = false,
                additional_vim_regex_highlighting = false,
            })
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            {
                'nvim-tree/nvim-web-devicons',
                dependencies = {
                    {
                        'rachartier/tiny-devicons-auto-colors.nvim',
                        config = function ()
                            require('tiny-devicons-auto-colors').setup({
                                colors = require("catppuccin.palettes").get_palette("mocha"),
                            })
                        end,
                        event = "VeryLazy",
                    },
                },
            },
        },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'catppuccin',
                    component_separators = '|',
                    section_separators = '',
                },
                sections = {
                    lualine_a = {
                        { 'mode' },
                    },
                    lualine_b = {
                        { 'location' },
                        { 'progress' },
                    },
                    lualine_c = {
                        { 'buffers' },
                    },
                    lualine_x = {
                        { 'diff' },
                        { 'diagnostics' },
                    },
                    lualine_y = {
                        { 'branch' },
                        { 'filetype' },
                    },
                    lualine_z = {
                    }
                }
            })
        end,
        event = 'VeryLazy',
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()

            vim.keymap.set({'n', 'v'}, '<leader>hs', '<CMD>Gitsigns stage_hunk<CR>', { desc='Stage git hunk', noremap=true, silent=true })
            vim.keymap.set({'n', 'v'}, '<leader>hu', '<CMD>Gitsigns undo_stage_hunk<CR>', { desc='Unstage git hunk', noremap=true, silent=true })
            vim.keymap.set({'n', 'v'}, '<leader>hp', '<CMD>Gitsigns preview_hunk<CR>', { desc='Stage git hunk', noremap=true, silent=true })
        end,
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup()
        end,
    },

    {
        'windwp/nvim-autopairs',
        dependencies = {
            {
                "hrsh7th/nvim-cmp",
            },
        },
        config = function()
            require("nvim-autopairs").setup()
            require("cmp").event:on("confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
        end,
        event = { "InsertEnter" },
    },

    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
        ft = {
            'javascript',
            'typescript',
            'html',
        },
    },

    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
        ft = { 'css' },
    },

}

