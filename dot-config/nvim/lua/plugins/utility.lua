return {

    {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
        end,
        event = "VeryLazy",
    },

    {
        'mbbill/undotree',
        init = function()
            vim.g.undotree_WindowLayout = 3
            vim.g.undotree_SplitWidth = 45
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, mode={'n', 'v'}, desc='Toggle undotree', noremap=true, silent=true },
        },
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()

            vim.keymap.set({'n', 'v'}, '<leader>hs', '<CMD>Gitsigns stage_hunk<CR>', { desc='Stage git hunk', noremap=true, silent=true })
            vim.keymap.set({'n', 'v'}, '<leader>hu', '<CMD>Gitsigns undo_stage_hunk<CR>', { desc='Unstage git hunk', noremap=true, silent=true })
            vim.keymap.set({'n', 'v'}, '<leader>hp', '<CMD>Gitsigns preview_hunk<CR>', { desc='Stage git hunk', noremap=true, silent=true })
        end,
    }

}
