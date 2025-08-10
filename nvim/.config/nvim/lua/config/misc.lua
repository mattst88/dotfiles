-- Make the clipboard automatically copy bidirectional
vim.opt.clipboard:append({'unnamedplus'})

-- Disable providers I never use and cause warnings in checkhealth
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Color the colum to the right of the limit
vim.opt.colorcolumn = "+1"

-- Options for completions. Move this at some point.
-- have a fixed column for the diagnostics to appear in this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

vim.keymap.set('n', '<Leader>gr', ':FzfLua grep_project<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gg', ':FzfLua git_files<cr>',    { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gf', ':FzfLua files<cr>',        { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<Leader>E', vim.diagnostic.setloclist)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.o.termguicolors = true

vim.g.table_mode_corner = "|"
