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

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local options = { buffer = ev.buf }
    vim.keymap.set('n', 'gD',                 vim.lsp.buf.declaration, options)
    vim.keymap.set('n', 'gd',                 vim.lsp.buf.definition, options)
    vim.keymap.set('n', 'K',                  vim.lsp.buf.hover, options)
    vim.keymap.set('n', 'gi',                 vim.lsp.buf.implementation, options)
    vim.keymap.set('n', '<C-k>',              vim.lsp.buf.signature_help, options)
    vim.keymap.set('n', '<c-\\>c',            vim.lsp.buf.incoming_calls, options)
    vim.keymap.set({'n', 'v'}, '<Leader>ca',  vim.lsp.buf.code_action, options)
    vim.keymap.set('n', '<Leader>rn',         vim.lsp.buf.rename, options)
    vim.keymap.set('n', '<c-\\>g',            vim.lsp.buf.references, options)
    vim.keymap.set('n', '<space>f', function ()
      vim.lsp.buf.format{ async = true }
    end, options)
  end,
})

vim.o.termguicolors = true
