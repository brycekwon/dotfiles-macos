return {
    "christoomey/vim-tmux-navigator",
    name = "tmux-navigator",
    lazy = true,  -- load on first key press
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
    keys = {
        { "<C-h>", "<CMD>TmuxNavigateLeft<CR>", mode = { "n", "t" }, desc = "Navigate left to tmux", noremap = true, silent = true },
        { "<C-j>", "<CMD>TmuxNavigateDown<CR>", mode = { "n", "t" }, desc = "Navigate down to tmux", noremap = true, silent = true },
        { "<C-k>", "<CMD>TmuxNavigateUp<CR>", mode = { "n", "t" }, desc = "Navigate up to tmux", noremap = true, silent = true },
        { "<C-l>", "<CMD>TmuxNavigateRight<CR>", mode = { "n", "t" }, desc = "Navigate right to tmux", noremap = true, silent = true },
    },
}

