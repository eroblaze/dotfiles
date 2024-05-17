local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].eroblaze_last_loc then
      return
    end
    vim.b[buf].eroblaze_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Add bindings for lsp stuffs after lsp has load
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(e)
    local function opts(description)
      return { buffer = e.buf, desc = description }
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Documentation"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Goto definition"))
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts("Type Definition"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Goto Implementation"))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
    -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic message"))
    -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic message"))
  end,
})

-- Fix conceal level for json files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})
