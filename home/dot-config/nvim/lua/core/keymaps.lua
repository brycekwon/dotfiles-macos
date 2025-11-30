vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- delete without overwriting default register
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "X", '"_X', { noremap = true, silent = true })
vim.keymap.set("n", "D", '"_D', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })

-- still learning...
vim.keymap.set({"n", "v"}, "<Up>", "k", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<Down>", "j", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<Left>", "h", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<Right>", "l", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<S-Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<S-Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<S-Left>", "^", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<S-Right>", "$", { noremap = true, silent = true })

-- jump to start/end of line
vim.keymap.set({"n", "v"}, "H", "^", { noremap = true, silent = true, desc = "Move to beginning of line" })
vim.keymap.set({"n", "v"}, "L", "$", { noremap = true, silent = true, desc = "Move to end of line" })

-- undo and redo changes
vim.keymap.set({"n", "v", "i"}, "<C-u>", "<CMD>undo<CR>", { noremap = true, silent = true, desc = "Undo Change" })
vim.keymap.set({"n", "v", "i"}, "<C-r>", "<CMD>redo<CR>", { noremap = true, silent = true, desc = "Redo Change" })

-- move highlighted chunks
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted block up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move highlighted block down" })

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { noremap = true, silent = true, desc = "Vertical Split Window" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { noremap = true, silent = true, desc = "Horizontal Split Window" })
vim.keymap.set("n", "<leader>sx", "<C-w>c", { noremap = true, silent = true, desc = "Close Window" })

-- buffer management
vim.keymap.set("n", "<C-t>", "<CMD>enew<CR>", { noremap = true, silent = true, desc = "New empty buffer" })
vim.keymap.set("n", "<C-q>", "<CMD>bdelete<CR>", { noremap = true, silent = true, desc = "Delete current buffer" })
vim.keymap.set("n", "<C-n>", "<CMD>bnext<CR>", { noremap = true, silent = true, desc = "Navigate to next buffer" })
vim.keymap.set("n", "<C-p>", "<CMD>bprevious<CR>", { noremap = true, silent = true, desc = "Navigate to previous buffer" })

-- disabled, unused, or remapped
vim.keymap.set({"n", "v"}, "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "0", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "u", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "q", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "$", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "^", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float(nil,{border="rounded"}) end)
vim.keymap.set("n", "<leader>dd", function() vim.diagnostic.open_float(0,{scope="cursor",border="rounded"}) end)
