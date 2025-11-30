return {
    "nvim-neo-tree/neo-tree.nvim",
    name = "neotree",
    version = "^3.38.0",
    -- branch = "v3.x",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            name = "plenary",
        },
        {
            "MunifTanjim/nui.nvim",
            name = "nui",
        },
        {
            "nvim-tree/nvim-web-devicons",
            name = "web-devicons",
        },
    },
    keys = {
        { "<leader>e", "<CMD>Neotree toggle<CR>", mode = { "n" }, desc = "Toggle NeoTree", noremap = true, silent = true },
        { "<leader>E", "<CMD>Neotree focus<CR>", mode = { "n" }, desc = "Focus NeoTree", noremap = true, silent = true },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            use_default_mappings = true,
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                    hide_by_name = {
                        "node_modules",
                        ".cache",
                        "__pycache__",
                    },
                    never_show = { ".DS_Store", "thumbs.db" },
                },
                follow_current_file = { enabled = true },
                group_empty_dirs = true,
                hijack_netrw_behavior = "open_default",
            },
            buffers = {
                follow_current_file = { enabled = true },
                group_empty_dirs = true,
            },
            git_status = {
                symbols = {
                    added     = "+",
                    modified  = "~",
                    deleted   = "-",
                    renamed   = "➜",
                    untracked = "?",
                    ignored   = "◌",
                    unstaged  = "✗",
                    staged    = "✓",
                    conflict  = "",
                },
            },
        })
    end,
}

