local function setup_lsp_keymaps(bufnr)
	local builtin = require("telescope.builtin")
	local opts = { buffer = bufnr, silent = true, noremap = true }

	vim.keymap.set("n", "gd", function() builtin.lsp_definitions({ jump_type = "tab" }) end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
	vim.keymap.set("n", "gr", function() builtin.lsp_references({ jump_type = "tab" }) end, vim.tbl_extend("force", opts, { desc = "Find references" }))
	vim.keymap.set("n", "gi", function() builtin.lsp_implementations({ jump_type = "tab" }) end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
	vim.keymap.set("n", "gT", function() builtin.lsp_type_definitions({ jump_type = "tab" }) end, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
	vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, vim.tbl_extend("force", opts, { desc = "Document symbols" }))
	vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

	vim.keymap.set("n", "<leader>ci", vim.lsp.buf.incoming_calls, vim.tbl_extend("force", opts, { desc = "Incoming calls" }))
	vim.keymap.set("n", "<leader>co", vim.lsp.buf.outgoing_calls, vim.tbl_extend("force", opts, { desc = "Outgoing calls" }))
end

return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    },
                    format = {
                        defaultConfig = {
                            indent_style = "tab",
                            indent_size = "4",
                            tab_width = "4"
                        }
                    }
                }
            }
        })

		vim.keymap.set("n", "<leader>.", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
		vim.keymap.set("n", "<leader>m", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				setup_lsp_keymaps(args.buf)

				vim.keymap.set("n", "<C-LeftMouse>", function()
					require("telescope.builtin").lsp_definitions({ jump_type = "tab" })
				end, { buffer = args.buf, desc = "Go to definition (Ctrl+click)" })
			end,
		})

		vim.lsp.enable("csharp_ls")
		vim.lsp.enable("lua_ls")

	end,
}
