-- Motivation: Make nvim faster when working on large files
return {
	"LunarVim/bigfile.nvim",
	config = function()
		require("bigfile").setup({
			filesize = 10, -- Size in MiB
			pattern = { "*" },
			features = { -- features to disable for big files
				"indent_blankline",
				"illuminate",
				"lsp",
				"treesitter",
				"syntax",
				"matchparen",
				"vimopts",
				"filetype",
			}
		})
	end
}
