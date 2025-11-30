return {
  "echasnovski/mini.statusline",
  name = "mini-statusline",
  version = "^0.16.0",
  event = "VeryLazy",
  dependencies = {
      {
          "nvim-tree/nvim-web-devicons",
          name = "web-devicons",
      },
  },
  config = function()
    local sl = require("mini.statusline")

    local function buffers_list(max)
      max = max or 70
      local cur = vim.api.nvim_get_current_buf()
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })

      local out, used = {}, 0
      for _, b in ipairs(bufs) do
        local name = b.name ~= "" and vim.fn.fnamemodify(b.name, ":t") or "[No Name]"
        if b.changed == 1 then name = name .. "+" end
        local item = (b.bufnr == cur) and ("[" .. name .. "]") or name

        local add = (used == 0) and item or (" " .. item)
        if used + #add > max then
          table.insert(out, " …")
          break
        end

        table.insert(out, add)
        used = used + #add
      end

      return table.concat(out)
    end

    sl.setup({
      use_icons = true,
      set_vim_settings = true,
      content = {
        active = function()
          local mode, mode_hl = sl.section_mode({ trunc_width = 120 })
          local filename = sl.section_filename({ trunc_width = 200 })
          local bufline = buffers_list(90)

          return sl.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineFilename", strings = { bufline } },
            { hl = "MiniStatuslineDevinfo", strings = { "%l", "%p%%" } },
          })
        end,

        inactive = function()
          local filename = sl.section_filename({ trunc_width = 200 })
          local bufline = buffers_list(90)

          return sl.combine_groups({
            { hl = "MiniStatuslineInactive", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineInactive", strings = { bufline, "%l", "%p%%" } },
          })
        end,
      },
    })
  end,
}

