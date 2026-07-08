return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp', 'b0o/schemastore.nvim' },
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers.lua_ls = {} -- added for blink.cmp
    opts.servers.pyright = {}
    -- Ensure ruff is installed via Mason
    opts.servers.ruff = {
      cmd = { "ruff", "server" },
      settings = {
        -- Options for ruff-lsp (older versions) or ruff server
        args = { "--length-sort" }, -- This sorts imports by length
      },
    }
    opts.servers.jsonls = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }
    return opts
  end,
 -- example calling setup directly for each LSP
  -- config = function()
  --   local capabilities = require('blink.cmp').get_lsp_capabilities()
  --   local lspconfig = require('lspconfig')
  --
  --   lspconfig['lua_ls'].setup({ capabilities = capabilities })
  -- end
}
