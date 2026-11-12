-- Justification: Neovim automatically integrates treesitter. To avoid errors
-- and manual language installations, this plugin.

-- Without this, treesitter file types need to manually installed and updated.
--
-- This uses the `main` branch. The old `master` branch is frozen and does not
-- work with Neovim 0.12. The `main` branch needs the tree-sitter CLI
-- (dev-util/tree-sitter-cli) to build parsers, and does not support
-- lazy-loading.
local languages = {
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
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
			callback = function(args)
				-- Set by bigfile.nvim for files over its size limit.
				if vim.b[args.buf].bigfile_disable_treesitter then
					return
				end
				-- Returns false (or errors) if no parser is installed for
				-- this filetype.
				if not pcall(vim.treesitter.start, args.buf) then
					return
				end
				vim.bo[args.buf].indentexpr =
					"v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
