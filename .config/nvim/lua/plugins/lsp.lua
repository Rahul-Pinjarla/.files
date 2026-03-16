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
  dependencies = { 'saghen/blink.cmp' },
  opts = {
    servers = {
      lua_ls = {}, -- added for blink.cmp
      -- Ensure ruff is installed via Mason
      ruff = {
        cmd = { "ruff", "server" },
      },
    },
  },
 -- example calling setup directly for each LSP
  -- config = function()
  --   local capabilities = require('blink.cmp').get_lsp_capabilities()
  --   local lspconfig = require('lspconfig')
  --
  --   lspconfig['lua_ls'].setup({ capabilities = capabilities })
  -- end
}
