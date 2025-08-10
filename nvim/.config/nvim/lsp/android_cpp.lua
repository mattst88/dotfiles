return {
	cmd = {'android_clangd.sh', 'local' },
	filetypes = {'c', 'cpp'},
	root_dir = function(bufnr, cb)
		-- Only return this if the files are there
		if vim.fs.root(bufnr, {'Android.bp', 'compile_commands.json'}) then
			cb(vim.fs.root(bufnr, {'compile_commands.json'}))
		end
	end,
}
