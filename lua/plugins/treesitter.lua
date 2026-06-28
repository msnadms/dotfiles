return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "lua", "javascript", "typescript", "tsx", "json", "html", "css", "markdown" },
      auto_install = true,
    })
  end,
}
