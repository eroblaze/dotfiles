return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    -- Keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>mf", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true,
      })
    end, {
      desc = "Lists files in your current working directory",
    })
    vim.keymap.set("n", "<leader>mr", builtin.oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader>ma", builtin.git_files, {
      desc = "Fuzzy search through the output of git ls-files command, respects .gitignore",
    })

    vim.keymap.set("n", "<leader>mg", function()
      builtin.live_grep({
        additional_args = { "--hidden" },
      })
    end, {
      desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
    })

    vim.keymap.set("n", "<leader>mw", function()
      builtin.grep_string({
        word_match = "-w",
      })
    end, {
      desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
    })

    vim.keymap.set("n", "<leader>md", function()
      builtin.diagnostics({
        bufnr = 0,
      })
    end, {
      desc = "Lists Diagnostics for all open buffers or a specific buffer",
    })

    vim.keymap.set(
      "n",
      "\\\\",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      { desc = "Lists open buffers" }
    )

    vim.keymap.set("n", "<leader>mp", function()
      builtin.find_files({
        cwd = require("lazy.core.config").options.root,
      })
    end, { desc = "Find Plugin File" })

    vim.keymap.set("n", "<leader>mh", builtin.help_tags, {
      desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
    })

    -- Initialization
    local opts = {
      defaults = {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
      pickers = {
        diagnostics = {
          -- theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
        oldfiles = {
          initial_mode = "normal",
        },
        buffers = {
          initial_mode = "normal",
        },
      },
    }
    require("telescope").setup(opts)
  end,
}
