vim.g.table_mode_corner = "|"

-- Put simply configured plugins here.
return {
  { "fladson/vim-kitty", ft = "kitty" },
  { "lukas-reineke/indent-blankline.nvim", version = "v3.6.3", main = "ibl", opts = {} },
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.adwaita_darker = true
        vim.cmd("colorscheme adwaita")
    end
  },
  { "norcalli/nvim-terminal.lua", opts = {} },
  "dhruvasagar/vim-table-mode",
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "rktjmp/paperplanes.nvim",
    opts = {
      register = "+",
      provider = "sprunge.us",
      provider_options = { insecure = true, },
      notifier = vim.notify or print,
    },
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {},
  },
}
