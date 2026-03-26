local keymap = vim.keymap

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>sc", "<C-w>c", { desc = "Close window" })
keymap.set("n", "<leader>so", "<C-w>o", { desc = "Close other windows" })

keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

keymap.set("n", "<leader><leader>", ":", { desc = "Command mode" })

keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })
