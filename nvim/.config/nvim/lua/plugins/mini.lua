-- Justification: Statusline which needs icons
-- indentscope: Visualize the code block
-- trailspace: Highlight trailing whitespace
return {
	{
		{
			"echasnovski/mini.icons",
			version = false,
			config = function()
				require("mini.icons").setup()
			end,
		},
		{
			"echasnovski/mini-git",
			version = false,
			main = 'mini.git',
			config = function(_, opts)
				-- Less nice version of integrated blame
				local align_blame = function(au_data)
					if au_data.data.git_subcommand ~= 'blame' then return end

					local win_src = au_data.data.win_source

					vim.wo.wrap = false
					vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
					vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })

					vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
				end

				local au_opts = { pattern = 'MiniGitCommandSplit', callback = align_blame }

				vim.api.nvim_create_autocmd('User', au_opts)

				require('mini.git').setup(opts)
			end,
			keys = {
				{ '<leader>gb', '<cmd>vert Git blame -- %<cr>',		    desc = '[G]it [B]lame in a split' },
				{ '<leader>gc', '<cmd>Git commit<cr>',                      desc = '[G]it [C]ommit' },
				{ '<leader>gC', '<cmd>Git commit --amend<cr>',              desc = '[G]it [C]ommit (Amend)' },
				{ '<leader>gl', '<cmd>Git log --oneline<cr>',               desc = '[G]it [L]og' },
				{ '<leader>gl', '<cmd>Git log --oneline --follow -- %<cr>', desc = '[G]it [L]og Buffer' },
				{ '<leader>gs', '<cmd>lua MiniGit.show_at_cursor()<cr>',    mode = 'n',                     desc = '[G]it [S]how' },
				{ '<leader>gs', '<cmd>lua MiniGit.show_at_cursor()<cr>',    mode = 'x',                     desc = '[G]it [S]how' },
				{ '<leader>gr', '<cmd>lua MiniGit.show_range_history()<cr>',    mode = 'n',                     desc = '[G]it [R]ange history' },
				{ '<leader>gr', '<cmd>lua MiniGit.show_rangehistory()<cr>',    mode = 'x',                     desc = '[G]it [R]ange history' },
				{ '<leader>ga', '<cmd>Git add -- %<cr>',                    desc = '[G]it [A]dd' },
			},
		},
		{
			'echasnovski/mini.diff',
			version = false,
			config = true,
			keys = {
				{ '<leader>go', '<cmd>lua MiniDiff.toggle_overlay()<cr>' },
			},
		},
		{
			"echasnovski/mini.statusline",
			version = false,
			config = function()
				require("mini.git").setup()
				local statusline = require("mini.statusline")
				statusline.setup {
					use_icons = vim.g.have_nerd_font
				}
			end,
		},
		{
			"echasnovski/mini.trailspace",
			version = false,
			config = function()
				require("mini.trailspace").setup()
			end,
		},
		{
			"echasnovski/mini.indentscope",
			version = false,
			config = function()
				require("mini.indentscope").setup({
					delay = 0,
				})
			end,
		},
		{
			"echasnovski/mini.notify",
			version = false,
			config = function()
				require("mini.notify").setup()
			end,
		},
	},
}
