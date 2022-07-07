local present, packer = pcall(require, "plugins.packerInit")
if not present then
   -- vim.notify("ERROR: PACKER NOT DETECTED", "error")
   return false
end
vim.cmd(
   [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
)

local function rcp(file_name)
   -- THis is a funciton RCP which stands for RequireConfigPath
   -- It's used for packer configs because they tend to be repetative and messy
   return "require('plugins.configs." .. file_name .. "')"
end

local plugins = {
   {"wbthomason/packer.nvim"},
   -- NEEDED TO LOAD FIRST --
   {"lewis6991/impatient.nvim"},
   {"nathom/filetype.nvim"},
   {"nvim-lua/popup.nvim"}, -- An implementation of the Popup API from vim in Neovim
   {"nvim-lua/plenary.nvim"}, -- Useful lua functions used ny lots of plugins
   {"kyazdani42/nvim-web-devicons"}, -- dev icons aa
   --TODO:use {'glepnir/dashboard-nvim', config = "require('plugins.dashboard')"}

   -- THEMES --
   {"folke/tokyonight.nvim"},
   {"morhetz/gruvbox"},
   {"AlphaTechnolog/onedarker.nvim"},
   -- Treesitter
   {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufRead", "BufNewFile" },
      run = ":TSUpdate",
      config = rcp "treesitter"
   },
   -- {"nvim-treesitter/playground", after = {"nvim-treesitter"}},
   {"windwp/nvim-ts-autotag", after = {"nvim-treesitter"}},
   {"nvim-treesitter/nvim-treesitter-textobjects", after = {"nvim-treesitter"}},
   {"nvim-treesitter/nvim-treesitter-refactor", after = {"nvim-treesitter"}},

   -- Telescope
   {
      "nvim-telescope/telescope.nvim",
      config = rcp "telescope",
      requires = {
         {"nvim-lua/popup.nvim"},
         {"nvim-lua/plenary.nvim"},
         {"nvim-telescope/telescope-fzf-native.nvim"}
      }
   },
   {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
   {"cljoly/telescope-repo.nvim"},
   {"nvim-telescope/telescope-ui-select.nvim"},
   -- { "nvim-telescope/telescope-media-files.nvim" }, -- Does not really work with WSL

   -- LSP BASE --
   {"neovim/nvim-lspconfig"}, -- enable LSP
   -- LSP cmp
   {"rafamadriz/friendly-snippets", module = "cmp_nvim_lsp", event = "InsertEnter"}, -- a bunch of snippets to use
   {"hrsh7th/nvim-cmp", config = rcp "cmp", after = "friendly-snippets"}, -- The completion plugin
   {"L3MON4D3/LuaSnip", wants = "friendly-snippets", after = "nvim-cmp"},
   {"saadparwaiz1/cmp_luasnip", after = "LuaSnip"},
   {"hrsh7th/cmp-nvim-lua", after = "cmp_luasnip"},
   {"hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua"},
   {"hrsh7th/cmp-buffer", after = "cmp-nvim-lsp"},
   {"hrsh7th/cmp-path", after = "cmp-buffer"},
   {"hrsh7th/cmp-calc", after = "cmp-path"},
   --{ "tzachar/cmp-tabnine", run = './install.sh', requires = 'hrsh7th/nvim-cmp', after = 'cmp-calc'},
   --{ "David-Kunz/cmp-npm", after = 'cmp-tabnine', requires = 'nvim-lua/plenary.nvim', config = rcp "cmp-npm"},
   {"Saecki/crates.nvim", after = "cmp-calc"},
   -- LSP addons
   {"williamboman/nvim-lsp-installer", event = "BufEnter", after = "cmp-nvim-lsp", config = "require('plugins.lsp.lsp-installer')"},
   -- TODO:{'stevearc/dressing.nvim', requires = 'MunifTanjim/nui.nvim', config = "require('plugins.dressing')"}
   -- TODO:{'onsails/lspkind-nvim'}
   {"folke/lsp-trouble.nvim", config = rcp("trouble")},
   {"tamago324/nlsp-settings.nvim"}, -- language server settings defined in json for ...
   --TODO:{'SmiteshP/nvim-gps', config = "require('plugins.gps')", after = 'nvim-treesitter'}
   -- exp TODO:{'jose-elias-alvarez/nvim-lsp-ts-utils', after = {'nvim-treesitter'}}
   {"simrat39/rust-tools.nvim", config = rcp "rust-tools"},


   -- General
   {"joosepAlviste/nvim-ts-context-commentstring", after = {"nvim-treesitter"}},
   {"numToStr/Comment.nvim", config = rcp "comment"}, -- comment stuff with gcc/gc
   {"akinsho/bufferline.nvim", config = rcp "bufferline"},
   {"moll/vim-bbye"},
   {"akinsho/toggleterm.nvim", config = rcp "toggleterm"}, -- terminal ztrl + /
   {"Pocco81/AutoSave.nvim", config = rcp "autosave"}, -- basic lua based autosave
   {"jose-elias-alvarez/null-ls.nvim", config = "require('plugins.lsp.null-ls')"}, -- for formatters and linters:wq
   {"folke/todo-comments.nvim"},
   {"rcarriga/nvim-notify"},


   -- Snippets & Language & Syntax
   {"windwp/nvim-autopairs", after = {"nvim-treesitter", 'nvim-cmp'}, config = rcp "autopairs"}, -- autom
   {"p00f/nvim-ts-rainbow", after = {"nvim-treesitter"}},
   {'lukas-reineke/indent-blankline.nvim', config = rcp "indent"},
   {'norcalli/nvim-colorizer.lua', config = rcp "colorizer"},

   -- Nvim Tree
   {"kyazdani42/nvim-tree.lua", config = rcp "nvim-tree"}, -- file explorer
   -- TODO: {"airblade/vim-rooter"},

   -- GIT
   {"lewis6991/gitsigns.nvim",
        requires = { 'nvim-lua/plenary.nvim' },
        config = rcp "gitsigns",
        event = "BufRead"
   },
   {"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim"},
}

-- TODO: see what this the fuc* means
-- label plugins for operational assistance
plugins = require("core.utils").label_plugins(plugins)
-- --remove plugins specified in chadrc
-- plugins = require("core.utils").remove_default_plugins(plugins)
-- --add plugins specified in chadrc
-- plugins = require("core.utils").add_user_plugins(plugins)

--
return packer.startup(
   function(use)
      for _, v in pairs(plugins) do
         use(v)
      end
   end
)
