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
          javascript = { "oxfmt" },
          typescript = { "oxfmt" },
          -- javascriptreact = { "oxfmt" },
          -- typescriptreact = { "oxfmt" },
          javascriptreact = { "prettierd" },
          typescriptreact = { "prettierd" },
          css = { "oxfmt" },
          scss = { "oxfmt" },
          html = { "oxfmt" },
          json = { "oxfmt" },
          yaml = { "oxfmt" },
          markdown = { "oxfmt" },
          graphql = { "oxfmt" },
          python = { "black" },
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
        },
        -- format_on_save = {
        --   timeout_ms = 1000,
        --   lsp_format = "fallback",
        -- },
        format_after_save = {
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
