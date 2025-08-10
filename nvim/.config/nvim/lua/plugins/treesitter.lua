-- Justification: Neovim automatically integrates treesitter. To avoid errors
-- and manual language installations, this plugin.

-- Without this, treesitter file types need to manually installed and updated.
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
	run = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
	event = "BufReadPost",
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"cpp",
			"git_config",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"ini",
			"json5",
			"lua",
			"make",
			"markdown",
			"meson",
			"ninja",
			"python",
			"rust",
			"toml",
			"vim",
			"yaml",
		},
	},
}
