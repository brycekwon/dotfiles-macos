return {

    {
        'alexghergh/nvim-tmux-navigation',
        config = function()
            require('nvim-tmux-navigation').setup({
                keybindings = {
                    left = '<C-h>',
                    right = '<C-l>',
                    up = '<C-k>',
                    down = '<C-j>',
                },
            })
        end,
    },

    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            {
                'nvim-lua/plenary.nvim',
            },
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
            {
                'MunifTanjim/nui.nvim',
            },
        },
        opts = {
            window = {
                position = "float",
                width = 120,
                height = 30,
            },
            filesystem = {
                default_expanded = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        '__pycache__',
                        '.git',
                    },
                },
            },
        },
        config = function(_, opts)
            require('neo-tree').setup(opts)
        end,
        keys = {
            {
                '<leader>e',
                '<CMD>Neotree toggle<CR>',
                mode={'n', 'v'},
                desc='Toggle filetree',
                noremap=true,
                silent=true
            },
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            {
                'nvim-lua/plenary.nvim',
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
        },
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')

            telescope.setup({
                defaults = {
                    path_display = { 'filename_first' },
                    mappings = {
                        i = {
                            ['<C-p>'] = actions.move_selection_previous,
                            ['<C-n>'] = actions.move_selection_next,
                        },
                    },
                    file_ignore_patterns = {
                        '%.png', '%.jpg', '%.jpeg', '%.webp', '%.gif', '%.icns', '%.pdf', '%.odt',
                        '%.docx', '%.ods', '%.xlsx', '%.pptx', '%.kdbx', '%.pcapng', '%.gpg',
                        '%.kbx', '%.bin', '%_%_pycache%_%_/*', '%.ipynb%_checkpoints/*'
                    },
                },
                pickers = {
                    find_files = {
                        find_command = { 'fd', '--hidden', '--type', 'file' },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                },
            })
            telescope.load_extension('fzf')
        end,
        keys = {
            { '<leader>ff', '<CMD>Telescope find_files<CR>', mode={'n', 'v'}, desc='Telescope find files', noremap=true, silent=true },
            { '<leader>fg', '<CMD>Telescope current_buffer_fuzzy_find<CR>', mode={'n', 'v'}, desc='Telescope search buffer', noremap=true, silent=true },
            { '<leader>fG', '<CMD>Telescope live_grep<CR>', mode={'n', 'v'}, desc='Telescope file grep', noremap=true, silent=true },
            { '<leader>fb', '<CMD>Telescope buffers<CR>', mode={'n', 'v'}, desc='Telescope buffers', noremap=true, silent=true },
            { '<leader>fd', '<CMD>Telescope diagnostics bufnr=0<CR>', mode={'n', 'v'}, desc='Telescope diagnostics', noremap=true, silent=true },
            { '<leader>fD', '<CMD>Telescope diagnostics<CR>', mode={'n', 'v'}, desc='Telescope diagnostics', noremap=true, silent=true },
            { '<leader>gb', '<CMD>Telescope git_branches<CR>', mode={'n', 'v'}, desc='Telescope git branches', noremap=true, silent=true },
            { '<leader>gh', '<CMD>Telescope git_commits<CR>', mode={'n', 'v'}, desc='Telescope git hashes', noremap=true, silent=true },
        },
    },

    {
        'theprimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            {
                'nvim-lua/plenary.nvim',
            },
        },
        keys = {
            { '<leader>aa', function() require('harpoon'):list():add() end, mode='n', desc='Add file to harpoon', noremap=true, silent=true },
            { '<leader>hh', function() local harpoon = require('harpoon') harpoon.ui:toggle_quick_menu(harpoon:list()) end, mode='n', desc='Toggle harpoon menu', noremap=true, silent=true },
            { '<leader>fh', '<CMD>Telescope harpoon marks<CR>', desc='Telescope harpoon', noremap=true, silent=true },
            { '<leader>1', function() require('harpoon'):list():select(1) end, mode='n', desc='Go to harpoon file #1', noremap=true, silent=true },
            { '<leader>2', function() require('harpoon'):list():select(2) end, mode='n', desc='Go to harpoon file #2', noremap=true, silent=true },
            { '<leader>3', function() require('harpoon'):list():select(3) end, mode='n', desc='Go to harpoon file #3', noremap=true, silent=true },
            { '<leader>4', function() require('harpoon'):list():select(4) end, mode='n', desc='Go to harpoon file #4', noremap=true, silent=true },
        }
    },

    {
        "folke/todo-comments.nvim",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
        },
        config = function(_, opts)
            require('todo-comments').setup(opts)

            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc="Next todo comment", noremap=true, silent=true })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc="Previous todo comment", noremap=true, silent=true })

            vim.keymap.set({'n', 'v'}, '<leader>ft', '<CMD>TodoTelescope<CR>', { noremap=true, silent=true} )
        end,
        event = 'VeryLazy',
    },

}
