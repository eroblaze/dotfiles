return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "rust",
          "query",
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "cpp",
          "c",
          "css",
          "scss",
          "fish",
          "gitignore",
        },

        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 3 },
    config = function()
      vim.keymap.set("n", "<leader>mc", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true, desc = "Jump up to Context" })
    end,
  },
}
