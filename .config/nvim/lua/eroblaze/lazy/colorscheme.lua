return {
  -- {
  --   "projekt0n/github-nvim-theme",
  --   priority = 1000,
  --   config = function()
  --     require("github-theme").setup({
  --       options = {
  --         dim_inactive = true,
  --         styles = {
  --           comments = "italic",
  --           functions = "NONE",
  --           keywords = "NONE",
  --           variables = "NONE",
  --           conditionals = "NONE",
  --           constants = "NONE",
  --           numbers = "NONE",
  --           operators = "NONE",
  --           strings = "NONE",
  --           types = "NONE",
  --         },
  --       },
  --     })
  --
  --     vim.cmd("colorscheme github_dark_dimmed")
  --   end,
  -- },

  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     require("rose-pine").setup({
  --       dim_inactive_windows = true,
  --       styles = {
  --         -- transparency = true,
  --       },
  --     })
  --
  --     vim.cmd("colorscheme rose-pine")
  --   end,
  -- },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    config = function()
      vim.cmd("colorscheme kanagawa-lotus")
    end,
  },

  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = true,
    config = function()
      vim.cmd("colorscheme solarized-osaka")
    end,
  },
}
