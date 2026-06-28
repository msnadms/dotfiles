return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = function()
    require("neogit").setup({
      kind = "vsplit",
    })

    vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Git status" })
  end,
}
