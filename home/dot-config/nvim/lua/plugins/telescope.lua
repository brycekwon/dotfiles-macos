return {
    "nvim-telescope/telescope.nvim",
    name = "telescope",
    version = "^0.2.0",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            name = "plenary",
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            name = "telescope-fzf-native",
            build = "make",
        },
    },
    keys = {
        { "<leader>fb", "<CMD>Telescope buffers<CR>", mode={"n", "v"}, desc="Telescope buffers", noremap=true, silent=true },
        { "<leader>ff", "<CMD>Telescope find_files<CR>", mode={"n", "v"}, desc="Telescope find files", noremap=true, silent=true },
        { "<leader>fg", "<CMD>Telescope current_buffer_fuzzy_find<CR>", mode={"n", "v"}, desc="Telescope search buffer", noremap=true, silent=true },
        { "<leader>fG", "<CMD>Telescope live_grep<CR>", mode={"n", "v"}, desc="Telescope file grep", noremap=true, silent=true },
        { "<leader>fd", "<CMD>Telescope diagnostics bufnr=0<CR>", mode={"n", "v"}, desc="Telescope diagnostics", noremap=true, silent=true },
        { "<leader>fD", "<CMD>Telescope diagnostics<CR>", mode={"n", "v"}, desc="Telescope diagnostics", noremap=true, silent=true },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                prompt_prefix = "🔍 ",
                selection_caret = " ",
                file_ignore_patterns = {
                    -- Node / Git
                    "node_modules/", ".git/",

                    -- Binary / images / documents
                    "%.exe$", "%.dll$", "%.so$", "%.dylib$",
                    "%.png$", "%.jpg$", "%.jpeg$", "%.gif$", "%.ico$", "%.pdf$",

                    -- Go cache / build artifacts
                    "%.test$", "%.out$", "vendor/", "bin/", "pkg/",

                    -- Python cache / build artifacts
                    "__pycache__/", "%.pyc$", "%.pyo$", "%.pyd$", "build/", "dist/", "venv/", "env/",

                    -- Jupyter
                    ".ipynb_checkpoints/", "%.ipynb_checkpoints/", "%.ipynb$",
                },
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                    width = 0.85,
                    height = 0.80,
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-c>"] = actions.close,
                    },
                    n = {
                        ["q"] = actions.close,
                    },
                },
            },
            pickers = {
                -- Use fd for clean relative paths
                find_files = {
                    find_command = { "fd", "--hidden", "--type", "file", "--type", "symlink" },
                },

                -- Use ripgrep for fast live grep
                live_grep = {
                    additional_args = function()
                        return { "--hidden", "--glob", "!node_modules/*" }
                    end,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        pcall(telescope.load_extension, "fzf")
    end,
}

