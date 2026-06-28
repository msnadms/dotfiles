return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    })

    vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame line" })
    vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
    vim.keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next git hunk" })
    vim.keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev git hunk" })
  end,
}
