return {
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({
			handlers = {
				gitsigns = true,
			},
		})
		require("scrollbar.handlers.gitsigns").setup()
	end,
}