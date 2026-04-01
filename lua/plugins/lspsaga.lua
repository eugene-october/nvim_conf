return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			-- UI Config
			ui = {
				-- Currently only round theme is supported
				title = true,
				-- Border type can be single, double, rounded, solid, shadow
				border = "rounded",
				winblend = 0,
				expand = "",
				collapse = "",
				code_action = "",
				incoming = "",
				outgoing = "",
				hover = "",
				kind = {},
			},
			-- Hover documentation
			hover = {
				max_width = 0.6,
				open_link = "gx",
				open_browser = "!chrome",
			},
			-- Diagnostic
			diagnostic = {
				on_insert = false,
				on_insert_follow = false,
				insert_winblend = 0,
				show_code_action = true,
				show_source = true,
				jump_num_shortcut = true,
				-- 1 is max
				max_width = 0.7,
				max_height = 0.6,
				max_show_width = 0.9,
				max_show_height = 0.6,
				text_hl_follow = false,
				border_follow = true,
				extend_relatedInformation = false,
				keys = {
					exec_action = "o",
					quit = "q",
					go_action = "g",
					toggle_or_jump = "<CR>",
					quit_in_show = { "q", "<ESC>" },
				},
			},
			-- Code action
			code_action = {
				num_shortcut = true,
				show_server_name = false,
				extend_gitsigns = false,
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},
			-- Lightbulb
			lightbulb = {
				enable = true,
				sign = true,
				sign_priority = 40,
				virtual_text = true,
			},
			-- Finder (definitions/references/implementations)
			finder = {
				max_height = 0.5,
				min_width = 30,
				force_max_height = false,
				keys = {
					jump_to = "p",
					expand_or_jump = "o",
					vsplit = "s",
					split = "i",
					tabe = "t",
					tabnew = "r",
					quit = { "q", "<ESC>" },
					close_in_preview = "<ESC>",
				},
			},
			-- Definition preview
			definition = {
				edit = "<C-c>o",
				vsplit = "<C-c>v",
				split = "<C-c>i",
				tabe = "<C-c>t",
				quit = "q",
				close = "<Esc>",
			},
			-- Rename
			rename = {
				quit = "<C-c>",
				exec = "<CR>",
				mark = "x",
				confirm = "<CR>",
				in_select = true,
			},
			-- Outline
			outline = {
				win_position = "right",
				win_with = "",
				win_width = 30,
				show_detail = true,
				auto_preview = true,
				auto_refresh = true,
				auto_close = true,
				custom_sort = nil,
				keys = {
					jump = "o",
					expand_collapse = "u",
					quit = "q",
				},
			},
			-- Call hierarchy
			callhierarchy = {
				show_detail = false,
				keys = {
					edit = "e",
					vsplit = "s",
					split = "i",
					tabe = "t",
					jump = "o",
					quit = "q",
					expand_collapse = "u",
				},
			},
			-- Symbol in winbar
			symbol_in_winbar = {
				enable = true,
				separator = " ",
				hide_keyword = true,
				show_file = true,
				folder_level = 2,
				respect_root = false,
				color_mode = true,
			},
			-- Beacon
			beacon = {
				enable = true,
				frequency = 7,
			},
		})

		-- Keymaps
		local opts = { silent = true, noremap = true }

		-- Hover
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

		-- Finder (definitions/references/implementation)
		vim.keymap.set("n", "gh", "<cmd>Lspsaga finder<CR>", vim.tbl_extend("force", opts, { desc = "LSP Finder" }))
		vim.keymap.set("n", "<leader>gf", "<cmd>Lspsaga finder def+ref+imp<CR>", vim.tbl_extend("force", opts, { desc = "Find definitions/references/implementation" }))

		-- Code action
		vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", vim.tbl_extend("force", opts, { desc = "Code actions" }))
		vim.keymap.set({ "n", "v" }, "<C-.>", "<cmd>Lspsaga code_action<CR>", vim.tbl_extend("force", opts, { desc = "Code actions" }))

		-- Rename
		vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		vim.keymap.set("n", "<leader>rN", "<cmd>Lspsaga rename ++project<CR>", vim.tbl_extend("force", opts, { desc = "Rename symbol in project" }))

		-- Definition/Declaration peek
		vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", vim.tbl_extend("force", opts, { desc = "Peek definition" }))
		vim.keymap.set("n", "<leader>gD", "<cmd>Lspsaga goto_definition<CR>", vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "<leader>gt", "<cmd>Lspsaga peek_type_definition<CR>", vim.tbl_extend("force", opts, { desc = "Peek type definition" }))
		vim.keymap.set("n", "<leader>gT", "<cmd>Lspsaga goto_type_definition<CR>", vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

		-- Diagnostics
		vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
		vim.keymap.set("n", "<leader>cD", "<cmd>Lspsaga show_buffer_diagnostics<CR>", vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" }))
		vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
		vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
		vim.keymap.set("n", "[e", function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, vim.tbl_extend("force", opts, { desc = "Previous error" }))
		vim.keymap.set("n", "]e", function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, vim.tbl_extend("force", opts, { desc = "Next error" }))

		-- Outline
		vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", vim.tbl_extend("force", opts, { desc = "Toggle outline" }))

		-- Call hierarchy
		vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", vim.tbl_extend("force", opts, { desc = "Incoming calls" }))
		vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", vim.tbl_extend("force", opts, { desc = "Outgoing calls" }))

		-- Float terminal
		vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle float terminal" }))
	end,
}
