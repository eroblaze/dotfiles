require("eroblaze.options")
require("eroblaze.keymaps")
require("eroblaze.lazy_init")
require("eroblaze.autocmds")

-- BORDER FOR HOVER AND SIGNATURE_HELP DOCUMENTATION

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  -- opts.max_height = opts.max_height or 7

  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
