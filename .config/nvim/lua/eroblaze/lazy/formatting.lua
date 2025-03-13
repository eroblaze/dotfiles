return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ui = {
        border = "rounded",
      },
    },
    config = function()
      require("conform").setup({

        formatters_by_ft = {
          javascript = { "prettierd" },
          typescript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescriptreact = { "prettierd" },
          svelte = { "prettierd" },
          css = { "prettierd" },
          scss = { "prettierd" },
          html = { "prettierd" },
          json = { "prettierd" },
          yaml = { "prettierd" },
          markdown = { "prettierd" },
          graphql = { "prettierd" },
          python = { "black" },
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "┊",
        tab_char = "┊",
      },
      scope = { enabled = false },
    },
    main = "ibl",
  },
}
