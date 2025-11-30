local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup("GeneralSettings", { clear = true })


-- reload files on external changes
autocmd({ "FocusGained", "BufEnter" }, {
    group = general,
    command = "checktime",
})

-- Trim trailing whitespace and ensure newline at end of file
vim.api.nvim_create_autocmd("BufWritePre", {
    group = general,
    pattern = "*",
    callback = function()
        -- Skip for markdown and gitcommit
        if vim.tbl_contains({ "markdown", "gitcommit" }, vim.bo.filetype) then
            return
        end

        -- trim whitespace
        vim.cmd([[%s/\s\+$//e]])

        -- Ensure file ends with a newline
        local line_count = vim.api.nvim_buf_line_count(0)
        local last_line = vim.api.nvim_buf_get_lines(0, line_count - 1, line_count, false)[1] or ""
        if last_line ~= "" then
            vim.api.nvim_buf_set_lines(0, line_count, line_count, false, { "" })
        end
    end,
})

-- visual on yank
autocmd("TextYankPost", {
    group = general,
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
            on_visual = true,
        })
    end,
})


-- remember cursor location
autocmd("BufReadPost", {
    group = general,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Show cursorline only in active window and when not in insert mode
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "InsertLeave" }, {
    group = general,
    callback = function()
        if vim.bo.buftype == "" then
            vim.opt_local.cursorline = true
        end
    end,
})

-- Hide cursorline in insert mode or inactive windows
vim.api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
    group = general,
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- change to tabs for golang
autocmd("FileType", {
    group = general,
    pattern = { "go", "make" },
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 0
    end,
})

