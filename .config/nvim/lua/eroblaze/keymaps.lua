vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>me", vim.cmd.Ex, { desc = "Open Ex(Explore)" })

vim.keymap.set("n", "TT", ":TransparentToggle<CR>", { noremap = true, desc = "Toggle background" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "y", '"+y', { noremap = true, silent = true, desc = "Yank into systems' clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system's clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system's clipboard" })

-- Split window
vim.keymap.set(
  "n",
  "<leader>mn",
  ":split<Return>",
  { noremap = true, silent = true, desc = "Split window horizontally" }
)
vim.keymap.set(
  "n",
  "<leader>mm",
  ":vsplit<Return>",
  { noremap = true, silent = true, desc = "Split window vertically" }
)

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
