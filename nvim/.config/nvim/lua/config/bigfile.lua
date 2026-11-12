-- Make nvim faster when working on large files.
--
-- Files over the limit get the "bigfile" filetype. Nothing (treesitter, LSP,
-- syntax) is set up for that filetype, so those stay off without having to
-- disable each one.
local limit = 10 * 1024 * 1024 -- 10 MiB

vim.filetype.add({
	pattern = {
		[".*"] = {
			function(path, buf)
				if not path or not buf or path ~= vim.api.nvim_buf_get_name(buf) then
					return
				end
				if vim.fn.getfsize(path) > limit then
					return "bigfile"
				end
			end,
			{ priority = math.huge },
		},
	},
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("bigfile", { clear = true }),
	pattern = "bigfile",
	callback = function(args)
		-- matchparen is global; this turns it off everywhere, until :DoMatchParen.
		if vim.fn.exists(":NoMatchParen") == 2 then
			vim.cmd.NoMatchParen()
		end

		vim.opt_local.swapfile = false
		vim.opt_local.foldmethod = "manual"
		vim.opt_local.undolevels = -1
		vim.opt_local.undoreload = 0
		vim.opt_local.list = false

		pcall(function()
			require("ibl").setup_buffer(args.buf, { enabled = false })
		end)
	end,
})
