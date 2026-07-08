return {
  -- aligns csv/tsv columns into a table and highlights each column;
  -- :CsvViewToggle to flip back to raw text, :CsvViewDisable to turn off
  "hat0uma/csvview.nvim",
  ft = { "csv", "tsv" },
  opts = {},
  config = function(_, opts)
    require("csvview").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv", "tsv" },
      callback = function()
        vim.cmd("CsvViewEnable")
      end,
    })
  end,
}
