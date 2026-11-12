return {
	{ "fladson/vim-kitty", ft = "kitty" },
	{ "lukas-reineke/indent-blankline.nvim", version = "v3.9.0", main = "ibl", opts = {} },

	-- Justification: Adwaita is my system theme
	{
		"Mofiqul/adwaita.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.adwaita_darker = true
			vim.cmd("colorscheme adwaita")
		end
	},
	-- Justification: Render ANSI color codes, e.g. in saved logs
	{
		"m00qek/baleia.nvim",
		version = "*",
		cmd = "BaleiaColorize",
		ft = "terminal",
		config = function()
			local baleia = require("baleia").setup({})

			vim.api.nvim_create_user_command("BaleiaColorize", function()
				baleia.once(vim.api.nvim_get_current_buf())
			end, {})

			-- `:setl ft=terminal` worked with nvim-terminal.lua; keep it.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "terminal",
				callback = function(args)
					baleia.once(args.buf)
				end,
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	"tpope/vim-eunuch",
	"vim-scripts/git_patch_tags.vim",
	'numToStr/Comment.nvim',
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true
	},
	{
		"rktjmp/paperplanes.nvim",
		opts = {
			register = "+",
			provider = "0x0.st",
			provider_options = {},
			notifier = vim.notify or print,
		},
	},

	-- Justification: I like being able to `:e foobar.c:854`
	{ "lewis6991/fileline.nvim" },

	-- Justification: clangd extensions are fun
	{ "p00f/clangd_extensions.nvim" },

	-- Justification: Markdown previewing
	{
		"euclio/vim-markdown-composer",
		build = "cargo build --release",
	},

	-- Justification: Nice to have
	{
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons" },
		opts = {
			fzf_bin = 'sk',
			file_icon_padding = '',
		}

	},
	-- Justification: Better Rust LSP experience
	{
		'mrcjkb/rustaceanvim',
		version = '^6', -- Recommended
		lazy = false, -- This plugin is already lazy
	}
}
