-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

-- vim.opt.clipboard = "unnamedplus" -- Already mapped 'y' to "+y
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.conceallevel = 2 -- Check ./autocmds.lua to see the fix for json files
vim.opt.confirm = true
vim.opt.cursorline = true

vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.completeopt = "menuone,noselect"
vim.opt.termguicolors = true

vim.opt.wrap = false

vim.opt.colorcolumn = "120"
vim.opt.scrolloff = 8

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"

-- undercurl
vim.cmd([[let &t_cs = "\e[4:3m"]])
vim.cmd([[let &t_ce = "\e[4:0m"]])

if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
end
