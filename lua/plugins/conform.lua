return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>==",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cs = function(bufnr)
				local csharpier_config_files = {
					".csharpierrc",
					".csharpierrc.json",
					".csharpierrc.yaml",
					".config/dotnet-tools.json",
				}

				local csharpier_config = require("conform.util").root_file(csharpier_config_files)(bufnr)

				if csharpier_config then
					return { "csharpier", lsp_format = "never" }
				else
					return { lsp_format = "fallback" }
				end
			end,
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

