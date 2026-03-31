return {
	"seblj/roslyn.nvim",
	opts = {},
	config = function()
		require("roslyn").setup()
		vim.lsp.config("roslyn", {
			settings = {
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "fullSolution",
					dotnet_compiler_diagnostics_scope = "fullSolution",
				},
			},
		})
	end,
}