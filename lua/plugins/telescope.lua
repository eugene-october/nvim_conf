return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "%.git/", "obj/", "bin/" },
			}
		})
		vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<D-p>", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<C-p>", function()
			builtin.git_files({ attach_mappings = function(_, map)
				map("i", "<CR>", actions.select_tab)
				map("n", "<CR>", actions.select_tab)
				return true
			end })
		end, { desc = "Git files (new tab)" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<C-F>", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
	end,
}
