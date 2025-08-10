-- Justification: I want code completion
--local M = {
return {
	"saghen/blink.cmp",
	event = { "InsertEnter" },
	-- Completions can be nice even when not attached to an LSP. If LSP only completions are wanted though
	--event = { "LspAttach" },
	version = "v1.*",
	dependencies = {
		{
			"echasnovski/mini.snippets",
			version = false,

			config = function()
				local gen_loader = require("mini.snippets").gen_loader
				require("mini.snippets").setup({
					snippets = {
						-- Load custom file with global snippets first (adjust for Windows)
						gen_loader.from_file("~/.config/nvim/snippets/global.json"),

						-- Load snippets based on current language by reading files from
						-- "snippets/" subdirectories from 'runtimepath' directories.
						gen_loader.from_lang(),
					},
				})
			end,
		},
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = { preset = "enter" },
		snippets = { preset = "mini_snippets" },
		fuzzy = {
			implementation = "prefer_rust_with_warning"
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			-- Some LSPs do brackets themsevles
			accept = { auto_brackets = { enabled = false } },
			documentation = { auto_show = false, },
			ghost_text = { enabled = true },
			menu = {
				-- Use mini.icons https://github.com/Saghen/blink.cmp/discussions/458
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ = require('mini.icons').get('lsp',
									ctx.kind)
								return kind_icon
							end,
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require('mini.icons').get('lsp',
									ctx.kind)
								return hl
							end,
						},
						kind = {
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require('mini.icons').get('lsp',
									ctx.kind)
								return hl
							end,
						}
					}
				},
			},

		},
	},
	opts_extend = { "sources.default" },

}

--[[
return {
	'echasnovski/mini.completion',
	version = false,
	event = { "InsertEnter" },
	config = function()
		require("mini.completion").setup()
	end,
--]]
