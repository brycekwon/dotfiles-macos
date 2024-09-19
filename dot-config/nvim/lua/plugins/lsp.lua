return {

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'hrsh7th/cmp-nvim-lsp',
            },
            {
                'williamboman/mason-lspconfig.nvim',
            },
        },
        config = function()
            local lspconfig = require('lspconfig')
            local mason_lsp = require('mason-lspconfig')

            local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            mason_lsp.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                lspconfig['lua_ls'].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                    [vim.fn.stdpath('config') .. '/lua'] = true,
                                },
                            },
                        },
                        telemetry = { enable = false },
                    },
                }),
            })
        end,
        event = { 'BufReadPre', 'BufNewFile' },
    },

    {
        'williamboman/mason.nvim',
        dependencies = {
            {
                'williamboman/mason-lspconfig.nvim',
            },
        },
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    },
                },
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls', 'clangd', 'cssls', 'gopls', 'html', 'marksman',
                    'jedi_language_server', 'lua_ls', 'ts_ls',
                },
            })
        end,
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'hrsh7th/cmp-path',
            },
            {
                'hrsh7th/cmp-buffer',
            },
            {
                'hrsh7th/cmp-cmdline',
            },
            {
                'L3MON4D3/LuaSnip',
                build = 'make install_jsregexp',
            },
            {
                'onsails/lspkind.nvim',
            },
        },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()

            local cmp = require('cmp')
            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone,preview,noselect',
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = 'nvim_lsp', keyword_length = 2 },
                    { name = 'luasnip', keyword_length = 2 },
                    { name = 'buffer', keyword_length = 0, max_item_count = 0, is_buffer = false },
                    { name = 'path', keyword_length = 1 },
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = {'menu', 'abbr', 'kind'},
                    format = require('lspkind').cmp_format({
                        maxwdith = 50,
                        ellipsis_char = '...',
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<S-TAB>'] = cmp.mapping.select_prev_item(),
                    ['<TAB>'] = cmp.mapping.select_next_item(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }),
                cmp.setup.cmdline({ '/', '?' }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'buffer' }
                    }
                }),
                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({}, {
                        {
                            option = {
                                ignore_cmds = { 'Man', '!' }
                            }
                        }
                    })
                })
            })

        end,
        event = 'InsertEnter',
    },

}

