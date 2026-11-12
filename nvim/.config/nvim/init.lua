
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

-- Turn off expensive features for large files
require("config.bigfile")

vim.cmd[[colorscheme adwaita]]
