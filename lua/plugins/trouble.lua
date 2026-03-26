return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		local trouble = require("trouble")
		vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, { desc = "Toggle Trouble" })
		vim.keymap.set("n", "<leader>xd", function() trouble.toggle({ mode = "diagnostics" }) end, { desc = "Toggle document diagnostics" })
		vim.keymap.set("n", "<leader>xl", function() trouble.toggle({ mode = "loclist" }) end, { desc = "Toggle location list" })
		vim.keymap.set("n", "<leader>xq", function() trouble.toggle({ mode = "quickfix" }) end, { desc = "Toggle quickfix list" })
	end,
}