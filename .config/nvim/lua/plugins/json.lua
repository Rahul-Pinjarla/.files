return {
  {
    -- :JqxList  - navigable outline of the current JSON buffer
    -- :JqxQuery - run a jq filter against the buffer and view the result
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "jsonc" },
  },
  {
    -- treesitter-aware folding for json/jsonc only; every other filetype
    -- keeps LazyVim's default indent-based foldmethod
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "json", "jsonc" },
        callback = function()
          vim.opt_local.foldmethod = "expr"
          vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.opt_local.foldlevel = 99
        end,
      })
    end,
  },
}
