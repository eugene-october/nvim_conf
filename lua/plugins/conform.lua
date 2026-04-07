return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufWritePost" },
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

				local bufname = vim.api.nvim_buf_get_name(bufnr)
				local dirname = vim.fn.fnamemodify(bufname, ":h")
				local csharpier_config = vim.fs.root(dirname, csharpier_config_files)

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
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
