return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Ensure ruff is installed via Mason
      ruff = {
        cmd = { "ruff", "server" },
        settings = {
          -- Options for ruff-lsp (older versions) or ruff server
          args = { "--length-sort" }, -- This sorts imports by length
        },
      },
    },
  },
}
