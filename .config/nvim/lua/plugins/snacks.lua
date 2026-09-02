return {
  {
    "folke/snacks.nvim",
    url = "https://github.com/Rahul-Pinjarla/snacks.nvim",
    opts = {
      explorer = {
        win = {
          list = {
            keys = {
              ["v"] = "vsplit",
              ["V"] = "split",
              ["e"] = {
                action = function(_, item)
                  if not item then
                    return
                  end
                  local winpath = vim.trim(vim.fn.system({ "wslpath", "-w", item.file }))
                  if vim.v.shell_error ~= 0 or winpath == "" then
                    Snacks.notify.error("Could not resolve a Windows path for `" .. item.file .. "`")
                    return
                  end
                  vim.fn.jobstart({ "explorer.exe", "/select," .. winpath }, { detach = true })
                end,
                desc = "Reveal in File Explorer (Windows)",
              },
            },
          },
        },
      },
      picker = {
        matcher = {
          ignorecase = true,
          smartcase = false,
        },
      },
      lazygit = {
        theme = {
          -- default inactiveBorderColor uses FloatBorder, which is nearly
          -- invisible against the panel background in catppuccin mocha;
          -- Comment has enough contrast to actually read inactive tabs
          inactiveBorderColor = { fg = "Comment" },
        },
      },
    },
  },
}
