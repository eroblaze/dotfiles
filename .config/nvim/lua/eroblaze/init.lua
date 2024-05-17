require("eroblaze.options")
require("eroblaze.keymaps")
require("eroblaze.lazy_init")
require("eroblaze.autocmds")

-- BORDER
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or "rounded"
--   opts.wrap = true
--   -- opts.max_height = opts.max_height or 7
--   -- return orig_util_open_floating_preview(contents, syntax, opts, ...)
--   local bufnr, winid = orig_util_open_floating_preview(contents, syntax, opts, ...)
--   print(bufnr, winid)
-- end
-- BORDER

-- local orig_util_stylize_markdown = vim.lsp.util.stylize_markdown
-- function vim.lsp.util.stylize_markdown(bufnr, contents, opts)
--   print("USING!")
--   opts = opts or {}
--   opts.separator = "||"
--   return orig_util_stylize_markdown(bufnr, contents, opts)
-- end

local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config({
  float = { border = _border },
})
