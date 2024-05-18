return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        dim_inactive_windows = true,
        styles = {
          transparency = true,
        },
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   name = "solarized-osaka",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("solarized-osaka").setup({
  --       transparent = false,
  --     })
  --     vim.cmd("colorscheme solarized-osaka")
  --   end,
  -- },
}
