return {
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        transparent = false,
      })
      vim.cmd("colorscheme solarized-osaka")
    end,
  },
  --
  -- { "bluz71/vim-nightfly-colors", lazy = true, priority = 1000, name = "nightfly" },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   opts = {
  --     -- background = {
  --     --     -- dark = "dragon",
  --     -- },
  --     transparent = true,
  --   },
  -- },
  -- {
  --   "Mofiqul/vscode.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   opts = {
  --     -- Enable transparent background
  --     transparent = true,
  --
  --     -- Enable italic comment
  --     italic_comments = true,
  --
  --     -- Disable nvim-tree background color
  --     disable_nvimtree_bg = true,
  --   },
  -- },
}
