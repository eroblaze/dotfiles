vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>me", vim.cmd.Ex, { desc = "Open Ex(Explore)" })

vim.keymap.set("n", "TT", ":TransparentToggle<CR>", { noremap = true, desc = "Toggle background" })

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Copying & Pasting
vim.keymap.set({ "n", "v" }, "y", '"+y', { noremap = true, desc = "Yank into system's clipboard" })
vim.keymap.set("n", "<leader>p", '"*p', { desc = "Paste from system's clipboard" })
vim.keymap.set("n", "<leader>P", '"*P', { desc = "Paste from system's clipboard" })

-- Split window
vim.keymap.set("n", "<leader>mn", ":split<Return>", { noremap = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>mm", ":vsplit<Return>", { noremap = true, desc = "Split window vertically" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
vim.keymap.set("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Tab management
vim.keymap.set("n", "<leader>t", ":tabnew<CR>", { noremap = true, desc = "Create a new tab" })
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { noremap = true, desc = "Move to the next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { noremap = true, desc = "Move to the previous tab" })
vim.keymap.set("n", "<leader>td", ":tabclose<CR>", { noremap = true, desc = "Close the current tab" })
