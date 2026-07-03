local frames = {
  "🌑",
  "🌒",
  "🌓",
  "🌔",
  "🌕",
  "🌖",
  "🌗",
  "🌘",
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local frame_index = 1
    local timer = (vim.uv or vim.loop).new_timer()
    timer:start(0, 150, vim.schedule_wrap(function()
      frame_index = (frame_index % #frames) + 1
      lualine.refresh()
    end))

    lualine.setup({
      options = { theme = "auto" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {
          function()
            return frames[frame_index]
          end,
        },
        lualine_z = { "location" },
      },
    })
  end,
}
