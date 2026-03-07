return {
  {
    "folke/snacks.nvim",
    url = "https://github.com/Rahul-Pinjarla/snacks.nvim",
    opts = {
      explorer = {
        win = {
          mappings = {
            ["v"] = "open_vsplit",
            ["V"] = "open_split",
          },
        },
      },
      picker = {
        matcher = {
          ignorecase = true,
          smartcase = false,
        },
      },
    },
  },
}
