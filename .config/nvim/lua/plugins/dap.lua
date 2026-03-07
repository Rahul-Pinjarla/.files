return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    opts = function(_, opts)
      -- Define a single layout (usually 'left' or 'bottom')
      opts.layouts = {
        {
          elements = {
            { id = "scopes", size = 0.40 }, -- Variable inspector
            { id = "stacks", size = 0.20 }, -- Call stack
            { id = "watches", size = 0.20 }, -- Watch expressions
            { id = "breakpoints", size = 0.20 }, -- Breakpoint list
          },
          size = 40, -- Width of the sidebar in columns
          position = "left", -- Change to "bottom" if you prefer it horizontal
        },
      }
      -- Disable the floating "repl" or "console" if you want them inside the tray too
      -- Or simply add { id = "repl", size = 0.1 } to the elements list above
    end,
  },

  -- Python integration
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- Use your venv python if you want; this is the simplest default
      require("dap-python").setup("python")
      local dap = require("dap")

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Django runserver",
          program = "${workspaceFolder}/manage.py",
          args = { "runserver" },
          django = true,
          console = "integratedTerminal",
          justMyCode = false,
        },
        {
          type = "python",
          request = "launch",
          name = "shell_plus",
          program = "${workspaceFolder}/manage.py",
          args = { "shell_plus" },
          django = true,
          console = "integratedTerminal",
          justMyCode = false,
        },
      }
    end,
  },
}
