return {
    "neovim/nvim-lspconfig",
    name = "nvim-lspconfig",
    version = "^2.5.0",
    dependencies = {
        {
            "mason-org/mason.nvim",
            name = "mason",
            version = "^2.1.0",
        },
        {
            "mason-org/mason-lspconfig.nvim",
            name = "mason-lspconfig",
            version = "^2.1.0",
        },
        {
            "hrsh7th/nvim-cmp",
            name = "cmp",
            dependencies = {
                {
                    "hrsh7th/cmp-nvim-lsp",
                    name = "cmp-lsp",
                },
                {
                    "hrsh7th/cmp-nvim-lsp-signature-help",
                    name = "cmp-signature",
                },
                {
                    "hrsh7th/cmp-path",
                    name = "cmp-path",
                },
                {
                    "hrsh7th/cmp-buffer",
                    name = "cmp-buffer",
                },
                {
                    "hrsh7th/cmp-cmdline",
                    name = "cmp-cmdline",
                    dependencies = {
                        {
                            "hrsh7th/cmp-nvim-lua",
                            name = "cmp-nvim-lua",
                        },
                    }
                },
            },
        },
    },

    cmd = "Mason",
    event = { "BufReadPre", "BufNewFile" },

    opts = {
        ensure_installed = {
            -- Python --
            "basedpyright",     -- lsp + type checker
            "ruff",             -- linter

            -- JavaScript/TypeScript --
            "ts_ls",            -- lsp + type checker
            -- "eslint-lsp",       -- linter

            -- HTML/CSS --
            -- "html-lsp",         -- lsp
            -- "css-lsp",          -- lsp

            -- Golang --
            "gopls",            -- lsp + type checker

            -- C/C++ --
            -- "clangd",           -- lsp + type checker

            -- Rust --
            -- "rust-analyzer",    -- lsp + type checker
        }
    },
    config = function(_, opts)
        require("mason").setup()
        require("mason-lspconfig").setup(opts)

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
            local cfg = { capabilities = capabilities }

            if server == "basedpyright" then
                cfg.settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "standard",
                            autoImportCompletions = true,
                            useLibraryCodeForTypes = true,
                        }
                    }
                }

            elseif server == "ts_ls" then
                cfg.settings = {
                    typescript = {
                        completions = {
                            completeFunctionCalls = true,
                        },
                    },
                    javascript = {
                        completions = {
                            completeFunctionCalls = true,
                        },
                    },
                }

            elseif server == "gopls" then
                cfg.settings = {
                    gopls = {
                        completeUnimported = true,
                        staticcheck = true,
                        gofumpt = true,
                        analyses = {
                            unusedparams = true,
                            nilness = true,
                            unusedwrite = true,
                        },
                    },
                }

            elseif server == "clangd" then
                cfg.filetypes = { "c", "cpp" }

            end

            vim.lsp.config(server, cfg)
            vim.lsp.enable(server)
        end

        local cmp = require("cmp")
        cmp.setup({
            sources = {
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp", keyword_length = 2 },
                { name = "buffer", keyword_length = 2 },
                { name = "path", keyword_length = 2 },
            },
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            },
            formatting = {
                fields = {"menu", "abbr", "kind"},
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        buffer = "[BUF]",
                        path = "[PATH]",
                        nvim_lsp_signature_help = "[SIGN]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<S-TAB>"] = cmp.mapping.select_prev_item(),
                ["<TAB>"] = cmp.mapping.select_next_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lua" },
            }, cmp.get_config().sources),
        })
    end
}

