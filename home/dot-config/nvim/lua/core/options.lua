--- VISUAL ---
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.cursorline = true

vim.opt.wrap = false
vim.opt.foldenable = false

vim.opt.signcolumn = "yes:1"
vim.opt.colorcolumn = "80,100"

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.showmode = false

vim.opt.showtabline = 0


--- FUNCTIONAL ---
vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = "menu,menuone,noselect"

-- undo history behavior
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- search behavior
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- whitespace display behavior
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "•", extends = "›", precedes = "‹", nbsp = "␣" }
vim.opt.fillchars = { eob = " " }

-- indentation behavior
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- window split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- disable backups and swapfiles
vim.opt.backup = false
vim.opt.swapfile = false


--- PERFORMANCE ---
vim.opt.timeoutlen = 500

vim.opt.lazyredraw = false
vim.opt.updatetime = 300
vim.opt.redrawtime = 10000

vim.opt.shortmess:append("I")
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

-- disable unused modules
local disabled_builtins = {
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logiPat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
    "matchparen",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}
for _, plugin in ipairs(disabled_builtins) do
    vim.g["loaded_" .. plugin] = 1
end

-- disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

