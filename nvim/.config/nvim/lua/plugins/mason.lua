-- Justification: Mason makes it easy to manage language servers, formatters
-- and linters. This helps keep consistent configuration accross deployments.
--
-- Language server implementation is handle in lsp/ - formatters and linters
-- are done here.

local M = {
	"williamboman/mason.nvim",
	dependencies = {
		{ "mfussenegger/nvim-lint",     lazy = true },
		{ "mhartington/formatter.nvim", lazy = true },
	},

	opts = {
		ensure_installed = {
			"bash-language-server",
			"clang-format",
			"clangd",
			"json-lsp",
			"lua-language-server",
			"marksman",
			"selene",
			"shellcheck",
			"shfmt",
			"stylua",
		},
	},
}

M.config = function()
	require("formatter").setup({
		-- Helpers for opt in formatters
		-- local util = require "formatter.util"

		filetype = {
			json = {
				require("formatter.filetypes.json").jq,
			},
			bp = {
				function()
					return {
						exe = "bpfmt",
						args = {
							"-o",
						},
						stdin = true,
					}
				end
			},
		},

		-- No matter the formatter, get rid of trailing whitespace
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		}
	})

	--[[
	 We rely on Language servers for formatting and linting when possible.
	require("lint").linters_by_ft = {
		bash = { "bash" },
		cpp = { "clang-tidy" },
		markdown = { "vale" },
		lua = { "selene" },
	}
	--]]
	require("mason").setup()
end

return { M }
