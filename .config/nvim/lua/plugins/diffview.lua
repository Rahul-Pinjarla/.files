return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: File history (repo)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File history (current file)" },
    },
    opts = {},
  },
}
