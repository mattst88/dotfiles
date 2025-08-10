vim.lsp.enable('clangd')
vim.lsp.enable('gopls')
vim.lsp.enable("markdown")
vim.lsp.enable("luals")


-- Copied from https://github.com/konradmalik/neovim-flake/blob/a63dd89c67bab313dc39046de582699a99385e8e/config/nvim/lua/pde/lsp/commands.lua#L10C1-L40C4
-- This function allows specifying the server id, but I do not ever want that.
---@param filter vim.lsp.get_clients.Filter?
local function restart_servers(filter)
	local clients = vim.lsp.get_clients(filter)
	---@type table<integer, {[1]: vim.lsp.Client, [2]: integer[]}>
	local detach_clients = {}
	for _, client in ipairs(clients) do
		detach_clients[client.id] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
		client:stop()
	end

	local timer = assert(vim.uv.new_timer(), "cannot create timer")
	timer:start(
		500,
		100,
		vim.schedule_wrap(function()
			for old_client_id, tuple in pairs(detach_clients) do
				local client = tuple[1]
				local attached_buffers = tuple[2]
				if client:is_stopped() then
					for _, buf in ipairs(attached_buffers) do
						vim.lsp.start(client.config, { bufnr = buf })
					end
					detach_clients[old_client_id] = nil
				end
			end

			if next(detach_clients) == nil and not timer:is_closing() then timer:close() end
		end)
	)
end

-- Stop the language server. Issuing :e after this will restart it
vim.api.nvim_create_user_command('LspStop', function(args)
	vim.lsp.stop_client(vim.lsp.get_clients())
end, {
	desc = "Stop the LSP server for all clients",
	nargs = 0,
})
--
-- Stop the language server. Issuing :e after this will restart it
vim.api.nvim_create_user_command('LspRestart', function(args)
	restart_servers()
end, {
	desc = "Restart the LSP server for all clients",
	nargs = 0,
})
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
--
-- This is mostly derived from nvim-lsp even though we're not using that plugin.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		-- Simple helper for mappings
		local function lsp_map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = args.buf
			vim.keymap.set(mode, l, r, opts)
		end


		-- Buffer local mappings.
		-- These are an unpleasant mix of ctags/global + vscode
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		lsp_map('n', 'gD',                 vim.lsp.buf.declaration)
		lsp_map('n', 'gd',                 vim.lsp.buf.definition)
		lsp_map('n', 'K',                  vim.lsp.buf.hover)
		lsp_map('n', 'gi',                 vim.lsp.buf.implementation)
		lsp_map('n', '<C-k>',              vim.lsp.buf.signature_help)
		lsp_map('n', '<c-\\>c',            vim.lsp.buf.incoming_calls)
		lsp_map({'n', 'v'}, '<Leader>ca',  vim.lsp.buf.code_action)
		lsp_map('n', '<Leader>rn',         vim.lsp.buf.rename)
		lsp_map('n', '<c-\\>g',            vim.lsp.buf.references)

		-- Format the whole file using LSP
		lsp_map("n", "<Leader>f", function()
			vim.lsp.buf.format({ async = true })
		end)

		-- Format the visual selection
		-- This doesn't seem to work for all servers
		lsp_map("v", "<leader>vf", function()
			vim.lsp.buf.format({
				async = true,
				["start"] = vim.api.nvim_buf_get_mark(0, "<"),
				["end"] = vim.api.nvim_buf_get_mark(0, ">"),
			})
		end)

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		--
		-- Enable inlay hints by default
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end

		-- Toggle inlay hints
		lsp_map("n", "<leader>it", function()
			local inlay = not vim.lsp.inlay_hint.is_enabled()
			vim.lsp.inlay_hint.enable(inlay, {})
		end)

		--[[
		-- Neovim as of .11 supports native completions. Blink.cmp still offers performance, and other advantages however, so don't use those.
		-- Currently using blink.cmp for completions
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
		end
		--]]

	end,
})
