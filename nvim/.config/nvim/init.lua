
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Folke's Lazy plugin management
require("config.lazy")

-- All LSP related configurations
require("config.lsp")

-- Not currently using linting, just LSP
-- require("config.linter")

-- Random
require("config.misc")

vim.cmd[[colorscheme adwaita]]
