return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	config = function()
		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		})

		local mr = require("mason-registry")
		if not mr.is_installed("stylua") then
			mr.install("stylua")
		end
	end,
}
