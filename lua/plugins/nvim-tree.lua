vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local api = require("nvim-tree.api")

		local function on_attach(bufnr)
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end

		require("nvim-tree").setup({
			on_attach = on_attach,
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
		})

		vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "Toggle file tree" })

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				if api.tree.is_visible() then
					api.tree.find_file({ buf = 0 })
				end
			end,
		})
	end,
}
